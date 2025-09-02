import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../HubConnectionHandler.dart';
import '../../models/classes/device.dart';

class DeviceDetailScreen extends StatefulWidget {
  final int deviceId;

  const DeviceDetailScreen ({ super.key, required this.deviceId });

  @override
  State<DeviceDetailScreen> createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {

  late Future<Device> deviceFuture;

  final HubConnectionHandler connectionHandler = GetIt.instance<HubConnectionHandler>();

  _DeviceDetailScreenState();

  @override
  void initState() {
    super.initState();
    try {
      deviceFuture = connectionHandler.getDevice(widget.deviceId);
    } on NotConnectedException {
      context.go("/connect");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    return Text(device.name);
  }
}
