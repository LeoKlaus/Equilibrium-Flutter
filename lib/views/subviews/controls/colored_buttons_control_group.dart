import 'package:equilibrium_flutter/models/classes/command.dart';
import 'package:equilibrium_flutter/models/enums/remote_button.dart';
import 'package:equilibrium_flutter/views/subviews/controls/command_button_if_exists.dart';
import 'package:flutter/material.dart';

class ColoredButtonsControlGroup extends StatelessWidget {
  final List<Command> commands;

  const ColoredButtonsControlGroup({super.key, required this.commands});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      children: [
        CommandButtonIfExists(commands: commands, button: RemoteButton.red, icon: Icon(Icons.rectangle_rounded, color: Colors.red)),
        CommandButtonIfExists(commands: commands, button: RemoteButton.green, icon: Icon(Icons.rectangle_rounded, color: Colors.green)),
        CommandButtonIfExists(commands: commands, button: RemoteButton.yellow, icon: Icon(Icons.rectangle_rounded, color: Colors.yellow)),
        CommandButtonIfExists(commands: commands, button: RemoteButton.blue, icon: Icon(Icons.rectangle_rounded, color: Colors.blue)),
      ],
    );
  }
}
