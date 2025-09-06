import 'package:flutter/material.dart';
import 'package:equilibrium_flutter/models/classes/command.dart';
import 'package:equilibrium_flutter/models/enums/remote_button.dart';
import 'package:collection/collection.dart';

class CommandButtonIfExists extends StatelessWidget {
  final Command? command;
  final bool useName;
  final Widget? icon;

  CommandButtonIfExists({
    super.key,
    required List<Command> commands,
    required RemoteButton button,
    this.useName = false,
    this.icon,
  }) : command = commands.firstWhereOrNull(
         (command) => command.button == button,
       );

  @override
  Widget build(BuildContext context) {
    return (command != null)
        ? IconButton(
            onPressed: () {},
            icon:
                icon ??
                (useName
                    ? Text(command!.name)
                    : Icon(command!.button.icon, size: 50)),
          )
        : Text("");
  }
}
