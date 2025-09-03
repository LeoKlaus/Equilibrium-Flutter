import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../helpers/hub_connection_handler.dart';
import '../../models/classes/device.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
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
    return Text(device.name);
  }
}
