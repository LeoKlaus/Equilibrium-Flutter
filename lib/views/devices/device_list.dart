import 'dart:developer' as developer;

import 'package:equilibrium_flutter/models/classes/device.dart';
import 'package:equilibrium_flutter/views/subviews/color_inverted.dart';
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

  Future<void> _refresh() async {
    List<Device> devices = await connectionHandler.getDevices();
    setState(() {
      devicesFuture = Future.value(devices);
    });
  }

  void deleteDevice(int id) async {
    await connectionHandler.api?.deleteDevice(id);
    await _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Devices')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).go("/devices/create", extra: _refresh);
        },
        child: Icon(Icons.add),
      ),
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
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 72),
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index];
          return TappableCard(
            onTap: () {
              GoRouter.of(context).go("/devices/${device.id}");
            },
            leadingTile: device.image?.id == null
                ? Icon(device.type.icon, size: 40)
                : ColorInverted(
                    child: Image.network(
                      height: 40,
                      width: 40,
                      "http://${connectionHandler.api?.baseUri ?? ""}/images/${device.image?.id}",
                      errorBuilder: (context, object, stacktrace) {
                        return Icon(Icons.error, size: 40, color: Colors.red,);
                      },
                    ),
                  ),
            title: device.name,
            subTitle: device.manufacturer == null
                ? device.model ?? ""
                : "${device.manufacturer ?? ""} ${device.model ?? ""}",
            trailingTile: PopupMenuButton(
              onSelected: (selection) {
                final id = device.id;
                if (id != null) {
                  switch (selection) {
                    case 1:
                      GoRouter.of(context).go("/devices/edit", extra: (device, _refresh));
                    case 2:
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Delete ${device.name}?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => {
                                Navigator.pop(context, 'Delete'),
                                deleteDevice(id),
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                  }
                } else {
                  developer.log("Couldn't get device id");
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      const Icon(Icons.edit),
                      SizedBox(width: 10),
                      const Text("Edit"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      const Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 10),
                      const Text("Delete", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
