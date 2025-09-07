import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:equilibrium_flutter/models/classes/command.dart';
import 'package:equilibrium_flutter/models/enums/remote_button.dart';
import 'package:collection/collection.dart';
import 'package:get_it/get_it.dart';
import 'package:equilibrium_flutter/helpers/hub_connection_handler.dart';

class CommandButtonIfExists extends StatelessWidget {
  final HubConnectionHandler connectionHandler =
  GetIt.instance<HubConnectionHandler>();

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
        constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
        onPressed: () {
          final id = command?.id;
          if (id != null) {
            connectionHandler.api?.sendCommand(id);
          } else {
            developer.log("Couldn't get command id");
          }
        },
        icon:
        icon ??
            (useName
                ? Text(command!.name)
                : SizedBox.expand(
              child: FittedBox(child: Icon(command!.button.icon)),
            )))
            : Text("");
  }
}
