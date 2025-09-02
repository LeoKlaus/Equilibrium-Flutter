import 'dart:developer' as developer;
import 'dart:io';

import 'package:equilibrium_flutter/models/classes/ble_device.dart';
import 'package:equilibrium_flutter/models/classes/user_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/hub_connection_handler.dart';
import '../subviews/tappable_card.dart';

class BluetoothDeviceList extends StatefulWidget {
  const BluetoothDeviceList({super.key});

  @override
  State<BluetoothDeviceList> createState() => _BluetoothDeviceListState();
}

class _BluetoothDeviceListState extends State<BluetoothDeviceList> {
  final HubConnectionHandler connectionHandler =
      GetIt.instance<HubConnectionHandler>();

  late Future<List<BleDevice>> devicesFuture;

  _BluetoothDeviceListState();

  Future<void> _refresh() async {
    List<BleDevice> devices = await connectionHandler.getBleDevices();
    setState(() {
      devicesFuture = Future.value(devices);
    });
  }

  @override
  void initState() {
    super.initState();
    devicesFuture = connectionHandler.getBleDevices();
  }

  Future<void> disconnectFromDevices() async {
    await connectionHandler.api?.disconnectBleDevices();
    setState(() {
      devicesFuture = connectionHandler.getBleDevices();
    });
  }

  Future<void> connectToDevice(String address) async {
    await connectionHandler.api?.connectBleDevice(address);
    setState(() {
      devicesFuture = connectionHandler.getBleDevices();
    });
  }

  List<Widget> connectionStatus(BleDevice device) {
    return [
      device.connected
          ? Text(style: TextStyle(color: Colors.green), "Connected")
          : Text(style: TextStyle(color: Colors.red), "Not connected"),
      device.paired
          ? Text(style: TextStyle(color: Colors.green), "Paired")
          : Text(style: TextStyle(color: Colors.red), "Not paired"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Bluetooth devices'),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: uploadImage,
        child: Icon(Icons.add),
      ),*/
      body: Center(
        child: FutureBuilder<List<BleDevice>>(
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

  Widget buildDevices(List<BleDevice> devices) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 72),
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index];
          return StyledCard(
            leadingTile: Icon(Icons.bluetooth),
            title: device.name,
            subTitle: device.address,
            trailingTile: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: connectionStatus(device),
                ),
                PopupMenuButton(
                  onSelected: (selection) async {
                    switch (selection) {
                      case 1:
                        await disconnectFromDevices();
                      case 2:
                        await connectToDevice(device.address);
                    }
                  },
                  itemBuilder:
                      (context) => [
                        device.connected
                            ? PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: [
                                  const Icon(Icons.bluetooth_connected),
                                  SizedBox(width: 10),
                                  Text("Disconnect from ${device.name}"),
                                ],
                              ),
                            )
                            : PopupMenuItem(
                              value: 2,
                              child: Row(
                                children: [
                                  const Icon(Icons.bluetooth_connected),
                                  SizedBox(width: 10),
                                  Text("Connect to ${device.name}"),
                                ],
                              ),
                            ),
                      ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
