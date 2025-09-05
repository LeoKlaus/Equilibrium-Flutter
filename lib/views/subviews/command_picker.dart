import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/hub_connection_handler.dart';
import '../../models/classes/command.dart';

class CommandPicker extends StatefulWidget {

  final Function(Command?) updateSelection;

  const CommandPicker({super.key, required this.updateSelection});

  @override
  State<StatefulWidget> createState() => _CommandPickerState();
}

class _CommandPickerState extends State<CommandPicker> {

  final HubConnectionHandler connectionHandler =
  GetIt.instance<HubConnectionHandler>();

  late Future<List<Command>> commandsFuture;

  @override
  void initState() {
    super.initState();
    commandsFuture = connectionHandler.getCommands();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Command>>(
      future: commandsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ListTile(
            title: Text("loading commands..."),
            leading: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          final commands = snapshot.data!;
          return DropdownMenu<Command?>(
            width: double.infinity,
            initialSelection: null,
            requestFocusOnTap: true,
            label: const Text('Add Command'),
            onSelected: widget.updateSelection,
            dropdownMenuEntries: commands.map((command) {
              return command.toDropDownMenuEntry();
            }).toList(),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 20,
              children: [
                Text("Error loading commands: ${snapshot.error}"),
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
          return DropdownMenu<Command?>(
            width: double.infinity,
            initialSelection: null,
            requestFocusOnTap: true,
            label: const Text('Command'),
            onSelected: widget.updateSelection,
            dropdownMenuEntries: [],
          );
        }
      },
    );
  }
}
