import 'package:equilibrium_flutter/models/classes/ble_device.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/hub_connection_handler.dart';
import '../subviews/styled_card.dart';
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

  Future<void> enableDiscovery() async {
    await connectionHandler.api?.advertiseBle();
  }

  Future<void> pairDevices() async {
    await connectionHandler.api?.pairDevices();
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

  Widget infoAndConnectSection() {
    return Padding(
      padding: EdgeInsetsGeometry.all(20),
      child: Column(
        spacing: 12,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
            child: /*Text(
              "**** from the Bluetooth settings of your device. For some devices (notably Apple TVs), pairing may not start automatically after connecting. In that case, use the **** ",
            ),*/ Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text:
                        "To pair Equilibrium to a new Bluetooth device, enable discovery here first and then connect to ",
                  ),
                  TextSpan(
                    text: "Equilibrium Virtual Keyboard",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        " from the Bluetooth settings of your device. For some devices (notably Apple TVs), pairing may not start automatically after connecting. In that case, use the ",
                  ),
                  TextSpan(
                    text: "Pair devices",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: " button below to manually initiate pairing."),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: enableDiscovery,
            child: ListTile(
              leading: Icon(Icons.search),
              title: Text("Enable discovery"),
            ),
          ),
          ElevatedButton(
            onPressed: pairDevices,
            child: ListTile(
              leading: Icon(Icons.bluetooth_connected_outlined),
              title: Text("Pair devices"),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
            child: Text(
              "Warning: The Bluetooth integration in Equilibrium should be considered experimental. While connecting to paired devices and controlling them (usually) works reliably, pairing can take a few attempts to work.",
              style: TextStyle(color: Theme.of(context).disabledColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDevices(List<BleDevice> devices) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
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
          infoAndConnectSection(),
        ],
      ),
    );
  }
}
