import 'dart:developer' as developer;

import 'package:equilibrium_flutter/models/classes/command.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:equilibrium_flutter/helpers/hub_connection_handler.dart';
import 'package:equilibrium_flutter/views/subviews/styled_card.dart';

class CommandList extends StatefulWidget {
  const CommandList({super.key});

  @override
  State<CommandList> createState() => _CommandListState();
}

class _CommandListState extends State<CommandList> {
  final HubConnectionHandler connectionHandler =
      GetIt.instance<HubConnectionHandler>();

  late Future<List<Command>> commandsFuture;

  _CommandListState();

  Future<void> _refresh() async {
    List<Command> commands = await connectionHandler.getCommands();
    setState(() {
      commandsFuture = Future.value(commands);
    });
  }

  @override
  void initState() {
    super.initState();
    commandsFuture = connectionHandler.getCommands();
  }

  @override
  void didUpdateWidget(covariant CommandList oldWidget) {
    super.didUpdateWidget(oldWidget);
    commandsFuture = connectionHandler.getCommands();
    developer.log("Updated widget!");
  }

  Future<void> sendCommand(int id) async {
    await connectionHandler.api?.sendCommand(id);
  }

  Future<void> deleteCommand(int id) async {
    await connectionHandler.api?.deleteCommand(id);
    setState(() {
      commandsFuture = connectionHandler.getCommands();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Commands'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).go("/settings/commands/create", extra: _refresh);
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: FutureBuilder<List<Command>>(
          future: commandsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final commands = snapshot.data!;
              return buildCommands(commands);
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

  Widget buildCommands(List<Command> commands) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 72),
        itemCount: commands.length,
        itemBuilder: (context, index) {
          final command = commands[index];
          return StyledCard(
            leadingTile: command.toDropDownMenuEntry().leadingIcon ?? Icon(command.button.icon),
            title: command.name,
            subTitle:
                command.device?.name != null
                    ? "${command.device?.name} - ${command.commandGroup.name()}"
                    : command.commandGroup.name(),
            trailingTile: PopupMenuButton(
              onSelected: (selection) async {
                final id = command.id;
                if (id != null) {
                  switch (selection) {
                    case 1:
                      await sendCommand(id);
                    case 2:
                      showDialog<String>(
                        context: context,
                        builder:
                            (BuildContext context) => AlertDialog(
                              title: Text('Delete ${command.name}?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed:
                                      () => Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed:
                                      () => {
                                        Navigator.pop(context, 'Delete'),
                                        deleteCommand(id),
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
                  developer.log("Couldn't get command id");
                }
              },
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: [
                          const Icon(Icons.send),
                          SizedBox(width: 10),
                          Text("Send ${command.name}"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Row(
                        children: [
                          const Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 10),
                          const Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
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
