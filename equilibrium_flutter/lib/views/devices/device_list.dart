import 'package:equilibrium_flutter/HubConnectionHandler.dart';
import 'package:equilibrium_flutter/models/classes/device.dart';
import 'package:equilibrium_flutter/repositories/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

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
    //loadDevices();
  }

  void loadDevices() async {
    try {
      final devices = await connectionHandler.getDevices();
    } on NotConnectedException {
      print("Received not connected while fetching devices");
      if (mounted) context.go("/connect");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return Text("Error: ${snapshot.error}");
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
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return GestureDetector(
          onTap: () {
            GoRouter.of(context).go("/devices/${device.id}");
          },
          child: Card(
            margin: EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    leading:
                        device.imageId == null
                            ? Icon(device.type.icon, size: 32)
                            : Image.network(
                              "http://${connectionHandler.api?.baseUri ?? ""}/images/${device.imageId}",
                            ),
                    title: Text(device.name),
                    subtitle:
                        device.manufacturer == null
                            ? Text(
                              device.model ?? "",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                              ),
                            )
                            : Text(
                              "${device.manufacturer ?? ""} ${device.model ?? ""}",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
