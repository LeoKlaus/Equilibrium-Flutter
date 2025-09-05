import 'package:equilibrium_flutter/models/classes/macro.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:equilibrium_flutter/helpers/hub_connection_handler.dart';
import 'package:multiselect_field/core/multi_select.dart';

class MultiMacroPicker extends StatefulWidget {

  final List<Macro>? initialSelection;
  final Function(List<Macro>) updateSelection;

  const MultiMacroPicker({super.key, required this.updateSelection, this.initialSelection});

  @override
  State<StatefulWidget> createState() => _MultiMacroPickerState();
}

class _MultiMacroPickerState extends State<MultiMacroPicker> {

  final HubConnectionHandler connectionHandler =
  GetIt.instance<HubConnectionHandler>();

  late Future<List<Macro>> macrosFuture;

  @override
  void initState() {
    super.initState();
    macrosFuture = connectionHandler.getMacros();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Macro>>(
      future: macrosFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ListTile(
            title: Text("loading macros..."),
            leading: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          final macros = snapshot.data!;
          return MultiSelectField<Macro>(
            defaultData: widget.initialSelection?.map((macro) {return Choice<Macro>(macro.id.toString(), macro.name ?? "Unnamed macro", metadata: macro);}).toList(),
            data: () => macros.map((macro) {
              return Choice<Macro>(macro.id.toString(), macro.name ?? "Unnamed macro", metadata: macro);
            }).toList(),
            onSelect: (selectedMacros, somethingElse) {
              widget.updateSelection(selectedMacros.map((macroChoice) {return macroChoice.metadata!;}).toList());
            },
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(5),
            ),
            title: (isEmpty) => Text("Macros"),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 20,
              children: [
                Text("Error loading macros: ${snapshot.error}"),
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
          return MultiSelectField<Macro>(
            data: () => [],
            onSelect: (selectedMacros, somethingElse) {},
          );
        }
      },
    );
  }
}
