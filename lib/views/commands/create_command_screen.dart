import 'dart:developer' as developer;

import 'package:equilibrium_flutter/models/classes/command.dart';
import 'package:equilibrium_flutter/models/enums/bluetooth_command.dart';
import 'package:equilibrium_flutter/models/enums/command_group_type.dart';
import 'package:equilibrium_flutter/models/enums/command_type.dart';
import 'package:equilibrium_flutter/models/enums/network_request_type.dart';
import 'package:equilibrium_flutter/models/enums/remote_button.dart';
import 'package:equilibrium_flutter/repositories/api_repository.dart';
import 'package:equilibrium_flutter/views/commands/create_ir_command_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/hub_connection_handler.dart';
import '../../models/classes/device.dart';
import '../../models/enums/bluetooth_command_type.dart';

class CreateCommandScreen extends StatefulWidget {
  const CreateCommandScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreateCommandScreenState();
}

class _CreateCommandScreenState extends State<CreateCommandScreen> {
  final HubConnectionHandler connectionHandler =
      GetIt.instance<HubConnectionHandler>();

  late TextEditingController _nameController;
  Device? device;
  CommandGroupType group = CommandGroupType.other;
  CommandType type = CommandType.infrared;
  RemoteButton button = RemoteButton.powerToggle;
  BluetoothCommandType btCommandType = BluetoothCommandType.regularKey;
  BluetoothCommand btCommand = BluetoothCommand.enter;
  late TextEditingController _btCommandKeyController;
  late TextEditingController _hostController;
  NetworkRequestType networkRequestType = NetworkRequestType.get;
  late TextEditingController _bodyController;

  late Future<List<Device>> devicesFuture;

  Future<void> createCommand() async {
    final command = Command(
      id: null,
      name: _nameController.text,
      button: button,
      type: type,
      commandGroup: group,
      deviceId: device?.id,
      host: (type == CommandType.network) ? _hostController.text : null,
      method: (type == CommandType.network) ? networkRequestType : null,
      body: (type == CommandType.network && networkRequestType.canHaveBody())
          ? _bodyController.text
          : null,
      btAction:
          (type == CommandType.bluetooth &&
              btCommandType == BluetoothCommandType.regularKey)
          ? btCommand.rawValue() ?? _btCommandKeyController.text
          : null,
      btMediaAction:
          (type == CommandType.bluetooth &&
              btCommandType == BluetoothCommandType.mediaKey)
          ? btCommand.rawValue()!
          : null,
    );

    try {
      final createdCommand = await connectionHandler.createCommand(command);
      developer.log("Created command ${createdCommand.name}");
      if (mounted) {
        GoRouter.of(context).go("/more/commands");
      }
    } on NotConnectedException {
      developer.log("No hub connected");
    } on InvalidResponseException catch (e) {
      developer.log(e.errorMessage());
    }
  }

  @override
  void initState() {
    super.initState();
    devicesFuture = connectionHandler.getDevices();
    _nameController = TextEditingController();
    _btCommandKeyController = TextEditingController();
    _hostController = TextEditingController();
    _bodyController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _btCommandKeyController.dispose();
    _hostController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('New Command'),
      ),
      body: ListView(
        itemExtent: 80,
        padding: EdgeInsetsGeometry.all(16),
        children:
            <Widget>[
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: "",
                  border: OutlineInputBorder(),
                ),
              ),
              devicePicker(),
              DropdownMenu<CommandGroupType>(
                width: double.infinity,
                initialSelection: CommandGroupType.other,
                requestFocusOnTap: false,
                label: const Text('Command group'),
                onSelected: (CommandGroupType? selectedType) {
                  setState(() {
                    group = selectedType ?? CommandGroupType.other;
                  });
                },
                dropdownMenuEntries: CommandGroupType.dropDownEntries,
              ),
              DropdownMenu<CommandType>(
                width: double.infinity,
                initialSelection: CommandType.infrared,
                requestFocusOnTap: false,
                label: const Text('Type'),
                onSelected: (CommandType? selectedType) {
                  setState(() {
                    type = selectedType ?? CommandType.infrared;
                  });
                },
                dropdownMenuEntries: CommandType.dropDownEntries,
              ),
              DropdownMenu<RemoteButton>(
                width: double.infinity,
                initialSelection: RemoteButton.dropDownEntries(
                  group,
                ).first.value,
                requestFocusOnTap: false,
                label: const Text('Button'),
                onSelected: (RemoteButton? selectedButton) {
                  setState(() {
                    button =
                        selectedButton ??
                        RemoteButton.dropDownEntries(group).first.value;
                  });
                },
                dropdownMenuEntries: RemoteButton.dropDownEntries(group),
              ),
            ] +
            switch (type) {
              CommandType.infrared => [
                CreateIrCommandButton(
                  nameController: _nameController,
                  deviceId: device?.id,
                  commandGroup: group,
                  button: button,
                  doneCallback: () {
                    GoRouter.of(context).go("/more/commands");
                  },
                ),
              ],
              CommandType.bluetooth => buildBluetoothSection(),
              CommandType.network => buildNetworkSection(),
              CommandType.script => buildScriptSection(),
            },
      ),
    );
  }

  Widget devicePicker() {
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
            onSelected: (Device? selectedDevice) {
              setState(() {
                device = selectedDevice;
              });
            },
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
            onSelected: (Device? selectedDevice) {
              setState(() {
                device = selectedDevice;
              });
            },
            dropdownMenuEntries: [],
          );
        }
      },
    );
  }

  List<Widget> buildBluetoothSection() {
    return [
      DropdownMenu<BluetoothCommandType>(
        width: double.infinity,
        initialSelection: BluetoothCommandType.regularKey,
        requestFocusOnTap: false,
        label: const Text('Key Type'),
        onSelected: (BluetoothCommandType? selectedType) {
          setState(() {
            btCommandType = selectedType ?? BluetoothCommandType.regularKey;
          });
        },
        dropdownMenuEntries: BluetoothCommandType.dropDownEntries,
      ),
      DropdownMenu<BluetoothCommand>(
        width: double.infinity,
        initialSelection: BluetoothCommand.dropDownEntries(
          btCommandType,
        ).first.value,
        requestFocusOnTap: false,
        label: const Text('Key'),
        onSelected: (BluetoothCommand? selectedCommand) {
          setState(() {
            btCommand =
                selectedCommand ??
                BluetoothCommand.dropDownEntries(btCommandType).first.value;
          });
        },
        dropdownMenuEntries: BluetoothCommand.dropDownEntries(btCommandType),
      ),
      if (btCommand == BluetoothCommand.other)
        TextField(
          controller: _btCommandKeyController,
          decoration: InputDecoration(
            labelText: 'Key code',
            hintText: "",
            border: OutlineInputBorder(),
          ),
        ),
      if (device?.bluetoothAddress == null)
        Text(
          style: TextStyle(color: Colors.red),
          "This device has no associated Bluetooth address! You can still create this command, but you might need to configure the connection for it to work.",
        ),

      ElevatedButton(onPressed: createCommand, child: Text("Create command")),
    ];
  }

  List<Widget> buildNetworkSection() {
    return [
      TextField(
        controller: _hostController,
        decoration: InputDecoration(
          labelText: 'Host',
          hintText: "http://my.server.local",
          border: OutlineInputBorder(),
        ),
      ),
      DropdownMenu<NetworkRequestType>(
        width: double.infinity,
        initialSelection: NetworkRequestType.get,
        requestFocusOnTap: false,
        label: const Text('Key'),
        onSelected: (NetworkRequestType? selectedType) {
          setState(() {
            networkRequestType = selectedType ?? NetworkRequestType.get;
          });
        },
        dropdownMenuEntries: NetworkRequestType.dropDownEntries,
      ),
      if (networkRequestType.canHaveBody())
        TextField(
          controller: _bodyController,
          decoration: InputDecoration(
            labelText: 'Body',
            hintText: "",
            border: OutlineInputBorder(),
          ),
        ),

      ElevatedButton(onPressed: createCommand, child: Text("Create command")),
    ];
  }

  List<Widget> buildScriptSection() {
    return [Text("Creating script commands is not yet supported.")];
  }
}
