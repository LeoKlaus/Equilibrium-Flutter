import 'dart:developer' as developer;

import 'package:equilibrium_flutter/helpers/command_helper.dart';
import 'package:equilibrium_flutter/models/enums/remote_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../helpers/hub_connection_handler.dart';
import '../../models/classes/command.dart';
import '../../models/classes/device.dart';
import '../subviews/common_controls.dart';

class DeviceDetailScreen extends StatefulWidget {
  final int deviceId;

  const DeviceDetailScreen({super.key, required this.deviceId});

  @override
  State<DeviceDetailScreen> createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  late Future<Device> deviceFuture;

  final HubConnectionHandler connectionHandler =
      GetIt.instance<HubConnectionHandler>();

  _DeviceDetailScreenState();

  @override
  void initState() {
    super.initState();
    deviceFuture = connectionHandler.getDevice(widget.deviceId);
  }

  List<Widget> powerButtonBuilder(List<Command>? commands) {
    return commands?.map((command) {
          return IconButton(
            onPressed: () {
              if(command.id != null) {
                connectionHandler.api?.sendCommand(command.id!);
              } else {
                developer.log("Couldn't get command id");
              }
            },
            icon: command.button == RemoteButton.powerToggle
                ? Icon(command.button.icon)
                : Icon(
                    command.button.icon,
                    color: command.button == RemoteButton.powerOff
                        ? Colors.red
                        : Colors.green,
                  ),
          );
        }).toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          FutureBuilder(
            future: deviceFuture,
            builder: (context, snapshot) {
              return Row(
                children: powerButtonBuilder(
                  snapshot.data?.commands?.powerCommands,
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<Device>(
          future: deviceFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final device = snapshot.data!;
              return buildDevice(device);
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  Widget buildDevice(Device device) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
      child: CommonControls(devices: [device]),
    );
  }
}
