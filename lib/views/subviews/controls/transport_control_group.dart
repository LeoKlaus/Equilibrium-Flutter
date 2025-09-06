import 'package:equilibrium_flutter/models/classes/command.dart';
import 'package:equilibrium_flutter/models/enums/remote_button.dart';
import 'package:equilibrium_flutter/views/subviews/controls/command_button_if_exists.dart';
import 'package:flutter/material.dart';

class TransportControlGroup extends StatelessWidget {
  final List<Command> commands;

  const TransportControlGroup({super.key, required this.commands});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 350, maxHeight: 150),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 5,
        children: [
          CommandButtonIfExists(commands: commands, button: RemoteButton.play),
          CommandButtonIfExists(commands: commands, button: RemoteButton.pause),
          CommandButtonIfExists(
            commands: commands,
            button: RemoteButton.playpause,
          ),
          CommandButtonIfExists(commands: commands, button: RemoteButton.stop),
          CommandButtonIfExists(
            commands: commands,
            button: RemoteButton.record,
          ),
          CommandButtonIfExists(
            commands: commands,
            button: RemoteButton.previousTrack,
          ),
          CommandButtonIfExists(
            commands: commands,
            button: RemoteButton.rewind,
          ),
          Text(""),
          CommandButtonIfExists(
            commands: commands,
            button: RemoteButton.fastForward,
          ),
          CommandButtonIfExists(
            commands: commands,
            button: RemoteButton.nextTrack,
          ),
        ],
      ),
    );
  }
}
