import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';

import '../../helpers/hub_connection_handler.dart';
import '../../models/classes/macro.dart';

class MacroPicker extends StatefulWidget {

  final String? label;
  final int? initialSelectionId;
  final Function(Macro?) updateSelection;

  const MacroPicker({super.key, required this.updateSelection, this.initialSelectionId, this.label});

  @override
  State<StatefulWidget> createState() => _MacroPickerState();
}

class _MacroPickerState extends State<MacroPicker> {

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
          return DropdownMenu<Macro?>(
            width: double.infinity,
            initialSelection: macros.firstWhereOrNull((macro) => macro.id == widget.initialSelectionId),
            requestFocusOnTap: false,
            label: Text(widget.label ??'Select macro'),
            onSelected: widget.updateSelection,
            dropdownMenuEntries: macros.map((macro) {
              return macro.toDropDownMenuEntry();
            }).toList()+
                [DropdownMenuEntry<Macro?>(value: null, label: "None")],
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 20,
              children: [
                Text("Error loading images: ${snapshot.error}"),
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
          return DropdownMenu<Macro?>(
            width: double.infinity,
            initialSelection: null,
            requestFocusOnTap: false,
            label: const Text('Image'),
            onSelected: widget.updateSelection,
            dropdownMenuEntries: [],
          );
        }
      },
    );
  }
}
