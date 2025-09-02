import 'package:equilibrium_flutter/models/classes/device.dart';
import 'package:equilibrium_flutter/views/subviews/tappable_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/hub_connection_handler.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({super.key});

  @override
  State<DeviceList> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  final HubConnectionHandler connectionHandler =
      GetIt.instance<HubConnectionHandler>();

  late Future<List<Device>> devicesFuture;

  _DeviceListState();

  @override
  void initState() {
    super.initState();
    devicesFuture = connectionHandler.getDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Devices')),
      body: Center(
        child: FutureBuilder<List<Device>>(
          future: devicesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final devices = snapshot.data!;
              return buildDevices(devices);
            } else if (snapshot.hasError) {
              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  spacing: 20,
                  children: [
                    Text("Error: ${snapshot.error}"),
                    ElevatedButton(
                      onPressed: () {
                        context.go("/connect");
                      },
                      child: Text("Check connected hub."),
                    ),
                  ],
                ),
              );
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  Widget buildDevices(List<Device> devices) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 72),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return TappableCard(
          onTap: () {
            GoRouter.of(context).go("/devices/${device.id}");
          },
          leadingTile:
              device.imageId == null
                  ? Icon(device.type.icon, size: 40)
                  : Image.network(
                    height: 40,
                    width: 40,
                    "http://${connectionHandler.api?.baseUri ?? ""}/images/${device.imageId}",
                  ),
          title: device.name,
          subTitle:
              device.manufacturer == null
                  ? device.model ?? ""
                  : "${device.manufacturer ?? ""} ${device.model ?? ""}",
        );
      },
    );
  }
}
