import 'package:equilibrium_flutter/models/classes/ble_device.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';
import '../../helpers/hub_connection_handler.dart';

class BluetoothDevicePicker extends StatefulWidget {
  final String? initialSelectionAddress;
  final Function(BleDevice?) updateSelection;

  const BluetoothDevicePicker({super.key, required this.updateSelection, this.initialSelectionAddress});

  @override
  State<StatefulWidget> createState() => _BluetoothDevicePickerState();
}

class _BluetoothDevicePickerState extends State<BluetoothDevicePicker> {
  final HubConnectionHandler connectionHandler =
      GetIt.instance<HubConnectionHandler>();

  late Future<List<BleDevice>> devicesFuture;

  @override
  void initState() {
    super.initState();
    devicesFuture = connectionHandler.getBleDevices();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BleDevice>>(
      future: devicesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ListTile(
            title: Text("loading bluetooth devices..."),
            leading: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          final devices = snapshot.data!;
          return DropdownMenu<BleDevice?>(
            width: double.infinity,
            initialSelection: devices.firstWhereOrNull((device) => device.address == widget.initialSelectionAddress),
            requestFocusOnTap: false,
            label: const Text('Select bluetooth device'),
            onSelected: widget.updateSelection,
            dropdownMenuEntries:
                devices.map((icon) {
                  return icon.toDropDownMenuEntry();
                }).toList() +
                [DropdownMenuEntry<BleDevice?>(value: null, label: "None")],
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 20,
              children: [
                Text("Error loading devices: ${snapshot.error}"),
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
          return DropdownMenu<BleDevice?>(
            width: double.infinity,
            initialSelection: null,
            requestFocusOnTap: false,
            label: const Text('Image'),
            onSelected: widget.updateSelection,
            dropdownMenuEntries: [],
          );
        }
      },
    );
  }
}
