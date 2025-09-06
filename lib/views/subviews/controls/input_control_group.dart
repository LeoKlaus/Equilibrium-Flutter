import 'package:equilibrium_flutter/models/classes/command.dart';
import 'package:equilibrium_flutter/models/enums/command_group_type.dart';
import 'package:flutter/material.dart';

class InputControlGroup extends StatelessWidget {
  final List<Command> commands;

  InputControlGroup({super.key, required List<Command> commands})
    : commands = commands
          .map(
            (command) =>
                command.commandGroup == CommandGroupType.input ? command : null,
          )
          .nonNulls
          .toList();

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      shrinkWrap: true,
      maxCrossAxisExtent: 90,
      mainAxisSpacing: 10,
      childAspectRatio: 1.5,
      children: commands.map((command) {
        return IconButton(onPressed: () {}, icon: Text(command.name, style: TextStyle(fontSize: 10)));
      }).toList(),
    );
  }
}
