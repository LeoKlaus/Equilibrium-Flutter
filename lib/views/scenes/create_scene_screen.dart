import 'dart:developer' as developer;

import 'package:equilibrium_flutter/models/classes/device.dart';
import 'package:equilibrium_flutter/models/classes/macro.dart';
import 'package:equilibrium_flutter/models/classes/scene.dart';
import 'package:equilibrium_flutter/models/classes/user_image.dart';
import 'package:equilibrium_flutter/views/subviews/bluetooth_device_picker.dart';
import 'package:equilibrium_flutter/views/subviews/image_picker.dart';
import 'package:equilibrium_flutter/views/subviews/macro_picker.dart';
import 'package:equilibrium_flutter/views/subviews/multi_device_picker.dart';
import 'package:equilibrium_flutter/views/subviews/multi_macro_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:equilibrium_flutter/helpers/hub_connection_handler.dart';

class CreateSceneScreen extends StatefulWidget {
  final Function reloadParent;

  final Scene? sceneToEdit;

  const CreateSceneScreen({
    super.key,
    required this.reloadParent,
    this.sceneToEdit,
  });

  @override
  State<StatefulWidget> createState() => _CreateSceneScreenState();
}

class _CreateSceneScreenState extends State<CreateSceneScreen> {
  final HubConnectionHandler connectionHandler =
      GetIt.instance<HubConnectionHandler>();

  late TextEditingController _nameController;

  UserImage? image;
  String? bleAddress;
  Macro? startMacro;
  Macro? stopMacro;
  List<Device> devices = [];
  List<Macro> macros = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.sceneToEdit?.name);
    image = widget.sceneToEdit?.image;
    bleAddress = widget.sceneToEdit?.bluetoothAddress;
    startMacro = widget.sceneToEdit?.startMacro;
    stopMacro = widget.sceneToEdit?.stopMacro;
    devices = widget.sceneToEdit?.devices ?? [];
    macros = widget.sceneToEdit?.macros ?? [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> saveScene() async {
    Scene newScene = widget.sceneToEdit ?? Scene();
    newScene.name = _nameController.text;
    newScene.imageId = image?.id;
    newScene.bluetoothAddress = bleAddress;
    newScene.startMacro = startMacro;
    newScene.stopMacro = stopMacro;
    newScene.devices = devices;
    newScene.macros = macros;

    final id = widget.sceneToEdit?.id;
    if (id != null) {
      final createdScene = await connectionHandler.api?.updateScene(
        id,
        newScene,
      );
      developer.log("Created scene ${createdScene?.name ?? ""}");
    } else {
      final updatedScene = await connectionHandler.api?.createScene(newScene);
      developer.log("Updated scene ${updatedScene?.name}");
    }
    if (mounted) {
      widget.reloadParent();
      GoRouter.of(context).go("/scenes");
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
        title: Text(widget.sceneToEdit?.name ?? 'New Scene'),
      ),
      body: ListView(
        //itemExtent: 80,
        padding: EdgeInsetsGeometry.all(16),
        children: <Widget>[
          SizedBox(
            height: 80,
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: "",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: ImagePicker(
              initialSelectionId: image?.id,
              updateSelection: (selectedImage) {
                setState(() {
                  image = selectedImage;
                });
              },
            ),
          ),
          SizedBox(
            height: 80,
            child: BluetoothDevicePicker(
              initialSelectionAddress: bleAddress,
              updateSelection: (selectedDevice) {
                setState(() {
                  bleAddress = selectedDevice?.address;
                });
              },
            ),
          ),
          SizedBox(
            height: 80,
            child: MacroPicker(
              label: "Select start macro",
              initialSelectionId: startMacro?.id,
              updateSelection: (selectedMacro) {
                setState(() {
                  startMacro = selectedMacro;
                });
              },
            ),
          ),
          MacroPicker(
            label: "Select stop macro",
            initialSelectionId: stopMacro?.id,
            updateSelection: (selectedMacro) {
              setState(() {
                stopMacro = selectedMacro;
              });
            },
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 18),
            child: MultiDevicePicker(
              initialSelection: devices,
              updateSelection: (selectedDevices) {
                setState(() {
                  devices = selectedDevices;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.directional(bottom: 18),
            child: MultiMacroPicker(
              initialSelection: macros,
              updateSelection: (selectedMacros) {
                setState(() {
                  macros = selectedMacros;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: saveScene,
            child: widget.sceneToEdit != null
                ? Text("Update scene")
                : Text("Create scene"),
          ),
        ],
      ),
    );
  }
}
