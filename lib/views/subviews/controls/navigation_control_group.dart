import 'package:equilibrium_flutter/models/classes/command.dart';
import 'package:equilibrium_flutter/models/enums/remote_button.dart';
import 'package:flutter/material.dart';
import 'package:equilibrium_flutter/views/subviews/controls/command_button_if_exists.dart';

class NavigationControlGroup extends StatelessWidget {
  final List<Command> commands;

  const NavigationControlGroup({super.key, required this.commands});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 250, maxHeight: 250),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        padding: EdgeInsetsGeometry.symmetric(vertical: 0, horizontal: 0),
        children: [
          CommandButtonIfExists(
            commands: commands,
            button: RemoteButton.exit,
            useName: true,
          ),
          CommandButtonIfExists(
            commands: commands,
            button: RemoteButton.directionUp,
          ),
          CommandButtonIfExists(
            commands: commands,
            button: RemoteButton.guide,
            useName: true,
          ),
          CommandButtonIfExists(
            commands: commands,
            button: RemoteButton.directionLeft,
          ),
          CommandButtonIfExists(
            commands: commands,
            button: RemoteButton.select,
          ),
          CommandButtonIfExists(
            commands: commands,
            button: RemoteButton.directionRight,
          ),
          CommandButtonIfExists(
            commands: commands,
            button: RemoteButton.menu,
            useName: true,
          ),
          CommandButtonIfExists(
            commands: commands,
            button: RemoteButton.directionDown,
          ),
          CommandButtonIfExists(
            commands: commands,
            button: RemoteButton.back,
            useName: true,
          ),
        ],
      ),
    );
  }
}
