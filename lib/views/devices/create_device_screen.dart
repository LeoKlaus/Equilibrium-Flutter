import 'dart:developer' as developer;

import 'package:equilibrium_flutter/models/classes/ble_device.dart';
import 'package:equilibrium_flutter/models/classes/device.dart';
import 'package:equilibrium_flutter/models/classes/user_image.dart';
import 'package:equilibrium_flutter/models/enums/device_type.dart';
import 'package:equilibrium_flutter/views/devices/bluetooth_device_picker.dart';
import 'package:equilibrium_flutter/views/subviews/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:equilibrium_flutter/helpers/hub_connection_handler.dart';

class CreateDeviceScreen extends StatefulWidget {
  final Function reloadParent;

  final Device? deviceToEdit;

  const CreateDeviceScreen({
    super.key,
    required this.reloadParent,
    this.deviceToEdit,
  });

  @override
  State<StatefulWidget> createState() => _CreateDeviceScreenState();
}

class _CreateDeviceScreenState extends State<CreateDeviceScreen> {
  final HubConnectionHandler connectionHandler = GetIt.instance<HubConnectionHandler>();

  late TextEditingController _nameController;
  late TextEditingController _manufacturerController;
  late TextEditingController _modelController;

  DeviceType type = DeviceType.other;
  UserImage? image;
  String? bleAddress;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.deviceToEdit?.name);
    _manufacturerController = TextEditingController(
      text: widget.deviceToEdit?.manufacturer,
    );
    _modelController = TextEditingController(text: widget.deviceToEdit?.model);
    type = widget.deviceToEdit?.type ?? DeviceType.other;
    image = widget.deviceToEdit?.image;
    bleAddress = widget.deviceToEdit?.bluetoothAddress;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _manufacturerController.dispose();
    _modelController.dispose();
    super.dispose();
  }

  Future<void> saveDevice() async {
    Device newDevice = widget.deviceToEdit ?? Device();
    newDevice.name = _nameController.text;
    newDevice.manufacturer = _manufacturerController.text;
    newDevice.model = _modelController.text;
    newDevice.type = type;
    newDevice.imageId = image?.id;
    newDevice.bluetoothAddress = bleAddress;

    final id = widget.deviceToEdit?.id;
    if (id != null) {
      final createdDevice = await connectionHandler.api?.updateDevice(
        id,
        newDevice,
      );
      developer.log("Created device ${createdDevice?.name ?? ""}");
    } else {
      final updatedDevice = await connectionHandler.api?.createDevice(newDevice);
      developer.log("Updated device ${updatedDevice?.name}");
    }
    if (mounted) {
      widget.reloadParent();
      GoRouter.of(context).go("/devices");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.deviceToEdit?.name ?? 'New Device'),
      ),
      body: ListView(
        itemExtent: 80,
        padding: EdgeInsetsGeometry.all(16),
        children: <Widget>[
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              hintText: "",
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: _manufacturerController,
            decoration: InputDecoration(
              labelText: 'Manufacturer',
              hintText: "",
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: _modelController,
            decoration: InputDecoration(
              labelText: 'Model',
              hintText: "",
              border: OutlineInputBorder(),
            ),
          ),
          DropdownMenu<DeviceType>(
            width: double.infinity,
            initialSelection: type,
            requestFocusOnTap: false,
            label: const Text('Type'),
            onSelected: (DeviceType? selectedType) {
              setState(() {
                type = selectedType ?? DeviceType.other;
              });
            },
            dropdownMenuEntries: DeviceType.dropDownEntries,
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
            child: Text(
              "Select the type that best fits your device. This information will be used to automatically suggest key maps for your remote.",
              style: TextStyle(color: Theme.of(context).disabledColor),
            ),
          ),
          ImagePicker(
            initialSelection: image,
            updateSelection: (selectedImage) {
              setState(() {
                image = selectedImage;
              });
            },
          ),
          BluetoothDevicePicker(
            initialSelectionAddress: bleAddress,
            updateSelection: (selectedDevice) {
              setState(() {
                bleAddress = selectedDevice?.address;
              });
            },
          ),
          ElevatedButton(
            onPressed: saveDevice,
            child: widget.deviceToEdit != null
                ? Text("Update device")
                : Text("Create device"),
          ),
        ],
      ),
    );
  }
}
