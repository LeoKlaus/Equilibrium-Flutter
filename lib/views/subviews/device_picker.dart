import 'package:equilibrium_flutter/models/classes/device.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/hub_connection_handler.dart';

class DevicePicker extends StatefulWidget {

  final Function(Device?) updateSelection;

  const DevicePicker({super.key, required this.updateSelection});

  @override
  State<StatefulWidget> createState() => _DevicePickerState();
}

class _DevicePickerState extends State<DevicePicker> {

  final HubConnectionHandler connectionHandler =
  GetIt.instance<HubConnectionHandler>();

  late Future<List<Device>> devicesFuture;

  @override
  void initState() {
    super.initState();
    devicesFuture = connectionHandler.getDevices();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Device>>(
      future: devicesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ListTile(
            title: Text("loading devices..."),
            leading: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          final devices = snapshot.data!;
          return DropdownMenu<Device?>(
            width: double.infinity,
            initialSelection: null,
            requestFocusOnTap: true,
            label: const Text('Device'),
            onSelected: widget.updateSelection,
            dropdownMenuEntries: devices.map((device) {
              return device.toDropDownMenuEntry();
            }).toList(),
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
          return DropdownMenu<Device?>(
            width: double.infinity,
            initialSelection: null,
            requestFocusOnTap: true,
            label: const Text('Device'),
            onSelected: widget.updateSelection,
            dropdownMenuEntries: [],
          );
        }
      },
    );
  }
}
