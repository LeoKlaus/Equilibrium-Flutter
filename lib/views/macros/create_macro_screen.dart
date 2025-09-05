import 'dart:developer' as developer;

import 'package:equilibrium_flutter/views/subviews/command_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/hub_connection_handler.dart';
import '../../models/classes/command.dart';
import '../../models/classes/macro.dart';
import '../subviews/styled_card.dart';
import 'package:flutter/services.dart';

class CreateMacroScreen extends StatefulWidget {
  final Function reloadParent;

  final Macro? macroToEdit;

  const CreateMacroScreen(
      {super.key, this.macroToEdit, required this.reloadParent});

  @override
  State<StatefulWidget> createState() => _CreateMacroState();
}

class _CreateMacroState extends State<CreateMacroScreen> {
  final HubConnectionHandler connectionHandler =
  GetIt.instance<HubConnectionHandler>();

  late TextEditingController _nameController;

  List<Command> commands = [];
  List<int> commandIds = [];
  List<TextEditingController> delayControllers = [];

  Future<void> saveMacro() async {
    if (delayControllers.length != commandIds.length - 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              "Number of delays and commands don't match, this is a bug."),
        ),
      );
      developer.log(
          "Commands: ${commands.length}, delays: ${delayControllers.length}");
      return;
    }

    Macro newMacro = widget.macroToEdit ?? Macro();
    newMacro.name = _nameController.text;
    newMacro.commands = commands;
    newMacro.commandIds = commandIds;
    newMacro.delays = delayControllers.map((controller) {
      try {
        return int.parse(controller.text);
      } on FormatException {
        return 0;
      }
    }).toList();


    final id = widget.macroToEdit?.id;
    if (id != null) {
      final createdMacro = await connectionHandler.api?.updateMacro(
        id,
        newMacro,
      );
      developer.log("Created command ${createdMacro?.name ?? ""}");
    } else {
      final updatedMacro = await connectionHandler.api?.createMacro(newMacro);
      developer.log("Created command ${updatedMacro?.name}");
    }
    if (mounted) {
      widget.reloadParent();
      GoRouter.of(context).go("/more/macros");
    }
  }

  @override
  void initState() {
    super.initState();
    commands = widget.macroToEdit?.commands ?? [];
    commandIds = widget.macroToEdit?.commandIds ?? [];
    delayControllers = widget.macroToEdit?.delays.map((delay) {
      return TextEditingController(text: delay.toString());
    }).toList() ?? [];
    _nameController = TextEditingController(text: widget.macroToEdit?.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('New Macro'),
      ),
      body: ListView(
        padding: EdgeInsetsGeometry.all(16),
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 12),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: "",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(bottom: 72),
            itemCount: commandIds.length,
            itemBuilder: (context, index) {
              final id = commandIds[index];
              final command = commands.firstWhere((command) {
                return command.id == id;
              });
              return StyledCard(
                leadingTile: SizedBox(),
                title: command.name,
                subTitleWidget: (index < delayControllers.length)
                    ? TextField(
                  controller: delayControllers[index],
                  decoration: InputDecoration(labelText: "Delay after"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                )
                    : SizedBox(),
                trailingTile: PopupMenuButton(
                  onSelected: (selection) async {
                    switch (selection) {
                      case 1:
                        setState(() {
                          commandIds.removeAt(index);
                          if (!commandIds.contains(id)) {
                            commands.remove(command);
                          }
                          if (index < delayControllers.length) {
                            delayControllers.removeAt(index);
                          } else if ((index == delayControllers.length) && delayControllers.isNotEmpty) {
                            delayControllers.removeLast();
                          } else if (commandIds.isEmpty ||
                              commandIds.length == 1) {
                            delayControllers = [];
                          }
                        });
                    }
                  },
                  itemBuilder: (context) =>
                  [
                    PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: [
                          const Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 10),
                          const Text(
                            "Remove",
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
          CommandPicker(
            updateSelection: (command) {
              if (command != null) {
                setState(() {
                  if (!commands.contains(command)) {
                    commands.add(command);
                  }
                  commandIds.add(command.id!);
                  if (commandIds.length > 1) {
                    delayControllers.add(TextEditingController());
                  } else {
                    delayControllers = [];
                  }
                });
              }
            },
          ),
          ElevatedButton(
            onPressed: saveMacro,
            child: widget.macroToEdit != null
                ? Text("Update macro")
                : Text("Create macro"),
          ),
        ],
      ),
    );
  }
}
