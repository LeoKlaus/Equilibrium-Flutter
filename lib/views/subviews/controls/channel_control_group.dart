import 'package:equilibrium_flutter/models/classes/command.dart';
import 'package:equilibrium_flutter/models/enums/remote_button.dart';
import 'package:flutter/material.dart';

import 'package:equilibrium_flutter/views/subviews/controls/command_button_if_exists.dart';

class ChannelControlGroup extends StatelessWidget {
  final List<Command> commands;

  const ChannelControlGroup({super.key, required this.commands});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 250),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CommandButtonIfExists(
            commands: commands,
            button: RemoteButton.channelUp,
          ),
          CommandButtonIfExists(
            commands: commands,
            button: RemoteButton.channelDown,
          ),
        ],
      ),
    );
  }
}
