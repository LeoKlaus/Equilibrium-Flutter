import 'dart:developer' as developer;

import 'package:equilibrium_flutter/models/classes/macro.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/hub_connection_handler.dart';
import '../subviews/styled_card.dart';

class MacroList extends StatefulWidget {
  const MacroList({super.key});

  @override
  State<StatefulWidget> createState() => _MacroListState();
}

class _MacroListState extends State<MacroList> {
  final HubConnectionHandler connectionHandler =
      GetIt.instance<HubConnectionHandler>();

  late Future<List<Macro>> macrosFuture;

  _MacroListState();

  void deleteMacro(int id) async {
    await connectionHandler.api?.deleteMacro(id);
    await _refresh();
  }

  Future<void> _refresh() async {
    List<Macro> macros = await connectionHandler.getMacros();
    setState(() {
      macrosFuture = Future.value(macros);
    });
  }

  @override
  void initState() {
    super.initState();
    macrosFuture = connectionHandler.getMacros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Macros'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).go("/more/macros/create", extra: _refresh);
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: FutureBuilder<List<Macro>>(
          future: macrosFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final macros = snapshot.data!;
              return buildMacros(macros);
            } else if (snapshot.hasError) {
              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  spacing: 20,
                  children: [
                    Text("Error: ${snapshot.error}"),
                    ElevatedButton(
                      onPressed: () {
                        context.go("/connect");
                      },
                      child: Text("Check connected hub."),
                    ),
                  ],
                ),
              );
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  Widget buildMacros(List<Macro> macros) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 72),
        itemCount: macros.length,
        itemBuilder: (context, index) {
          final macro = macros[index];
          return StyledCard(
            leadingTile: Icon(Icons.keyboard_command_key),
            title: macro.name ?? "Unnamed Macro",
            subTitle: "${macro.commandIds?.length ?? 0} commands",
            trailingTile: PopupMenuButton(
              onSelected: (selection) {
                final id = macro.id;
                if (id != null) {
                  switch (selection) {
                    case 1:
                      connectionHandler.api?.executeMacro(id);
                    case 2:
                      GoRouter.of(context).go("/more/macros/edit", extra: (macro, _refresh));
                    case 3:
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Delete ${macro.name}?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => {
                                Navigator.pop(context, 'Delete'),
                                deleteMacro(id),
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                  }
                } else {
                  developer.log("Couldn't get icon id");
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      const Icon(Icons.send),
                      SizedBox(width: 10),
                      const Text("Execute"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      const Icon(Icons.edit),
                      SizedBox(width: 10),
                      const Text("Edit"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: [
                      const Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 10),
                      const Text("Delete", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
