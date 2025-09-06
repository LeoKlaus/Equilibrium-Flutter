import 'package:equilibrium_flutter/views/subviews/controls/channel_control_group.dart';
import 'package:equilibrium_flutter/views/subviews/controls/colored_buttons_control_group.dart';
import 'package:equilibrium_flutter/views/subviews/controls/input_control_group.dart';
import 'package:equilibrium_flutter/views/subviews/controls/navigation_control_group.dart';
import 'package:equilibrium_flutter/views/subviews/controls/transport_control_group.dart';
import 'package:equilibrium_flutter/views/subviews/controls/volume_control_group.dart';
import 'package:flutter/material.dart';
import 'package:equilibrium_flutter/models/classes/device.dart';
import 'package:equilibrium_flutter/helpers/controller_getters.dart';

class CommonControls extends StatelessWidget {
  final List<Device> devices;
  final Device? inputController;
  final Device? audioController;
  final Device? navigationController;
  final Device? channelController;

  CommonControls({super.key, required this.devices})
    : inputController = devices.inputController,
      audioController = devices.audioController,
      navigationController = devices.navigationController,
      channelController = devices.channelController;

  @override
  Widget build(BuildContext context) {
    // TODO: This overflows on small screens
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InputControlGroup(commands: inputController?.commands ?? []),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 350),
          child: Row(
            children: [
              VolumeControlGroup(commands: audioController?.commands ?? []),
              NavigationControlGroup(
                commands: navigationController?.commands ?? [],
              ),
              ChannelControlGroup(commands: channelController?.commands ?? []),
            ],
          ),
        ),
        TransportControlGroup(commands: navigationController?.commands ?? []),
        ColoredButtonsControlGroup(
          commands: navigationController?.commands ?? [],
        ),
      ],
    );
  }
}
