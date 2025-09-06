import 'package:equilibrium_flutter/models/classes/command.dart';
import 'package:equilibrium_flutter/models/enums/remote_button.dart';
import 'package:flutter/material.dart';

extension PowerCommands on List<Command> {
  List<Command> get powerCommands {
    return map(
      (command) =>
          (command.button == RemoteButton.powerToggle ||
              command.button == RemoteButton.powerOn ||
              command.button == RemoteButton.powerOff)
          ? command
          : null,
    ).nonNulls.toList();
  }
}


