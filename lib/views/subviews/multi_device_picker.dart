import 'package:equilibrium_flutter/models/classes/device.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:equilibrium_flutter/helpers/hub_connection_handler.dart';
import 'package:multiselect_field/core/multi_select.dart';

class MultiDevicePicker extends StatefulWidget {

  final List<Device>? initialSelection;
  final Function(List<Device>) updateSelection;

  const MultiDevicePicker({super.key, required this.updateSelection, this.initialSelection});

  @override
  State<StatefulWidget> createState() => _MultiDevicePickerState();
}

class _MultiDevicePickerState extends State<MultiDevicePicker> {

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
          return MultiSelectField<Device>(
            defaultData: widget.initialSelection?.map((device) {return Choice<Device>(device.id.toString(), device.name, metadata: device);}).toList(),
            data: () => devices.map((device) {
              return Choice<Device>(device.id.toString(), device.name, metadata: device);
            }).toList(),
            onSelect: (selectedDevices, somethingElse) {
              widget.updateSelection(selectedDevices.map((deviceChoice) {return deviceChoice.metadata!;}).toList());
            },
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(5),
            ),
            title: (isEmpty) => Text("Devices"),
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
          return MultiSelectField<Device>(
            data: () => [],
            onSelect: (selectedDevices, somethingElse) {},
          );
        }
      },
    );
  }
}
