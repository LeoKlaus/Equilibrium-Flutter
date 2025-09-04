import 'dart:convert';
import 'dart:developer' as developer;

import 'package:equilibrium_flutter/models/enums/command_group_type.dart';
import 'package:equilibrium_flutter/models/enums/command_type.dart';
import 'package:equilibrium_flutter/models/enums/remote_button.dart';
import 'package:equilibrium_flutter/models/enums/websocket_ir_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../../helpers/hub_connection_handler.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../models/classes/command.dart';

class CreateIrCommandButton extends StatefulWidget {
  final TextEditingController nameController;
  final int? deviceId;
  final CommandGroupType commandGroup;
  final RemoteButton button;
  final Function doneCallback;

  const CreateIrCommandButton({
    super.key,
    required this.doneCallback,
    required this.nameController,
    this.deviceId,
    required this.commandGroup,
    required this.button,
  });

  @override
  State<StatefulWidget> createState() => _CreateIrCommandButtonState();
}

class _CreateIrCommandButtonState extends State<CreateIrCommandButton> {
  final HubConnectionHandler connectionHandler =
      GetIt.instance<HubConnectionHandler>();

  WebsocketIrResponse? currentStatus;
  WebSocketChannel? _socket;

  void _connectToSocket() {
    _socket = WebSocketChannel.connect(
      Uri.parse('ws://${connectionHandler.api?.baseUri}/ws/commands'),
    );

    _socket?.stream.listen(_handleSocketUpdate);

    final newCommand = Command(
      name: widget.nameController.text,
      deviceId: widget.deviceId,
      commandGroup: widget.commandGroup,
      type: CommandType.infrared,
      button: widget.button,
    );

    _socket?.sink.add(json.encode(newCommand.toJson()));
  }

  void _disconnectFromSocket() {
    _socket?.sink.close();
  }

  void _handleSocketUpdate(dynamic value) async {
    final body = jsonDecode(value);
    try {
      final newState = WebsocketIrResponse.fromValue(body);

      setState(() {
        currentStatus = newState;
      });
      switch (newState) {
        case WebsocketIrResponse.pressKey ||
            WebsocketIrResponse.repeatKey ||
            WebsocketIrResponse.shortCode:
          break;
        case WebsocketIrResponse.done:
          HapticFeedback.lightImpact();
          await Future.delayed(Duration(seconds: 1));
          widget.doneCallback();
        case WebsocketIrResponse.cancelled ||
            WebsocketIrResponse.tooManyRetries:
          _disconnectFromSocket();
      }
    } on DecodingException catch (e) {
      developer.log("Couldn't decode response: ${e.key}");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (currentStatus) {
      case null:
        return ElevatedButton(
          onPressed: _connectToSocket,
          child: Text("Start learning command"),
        );
      case WebsocketIrResponse.pressKey:
        return ElevatedButton(
          onPressed: () {},
          child: ListTile(
            leading: CircularProgressIndicator(),
            title: Text("Press key for ${widget.nameController.text}"),
          ),
        );
      case WebsocketIrResponse.repeatKey:
        return ElevatedButton(
          onPressed: () {},
          child: ListTile(
            leading: CircularProgressIndicator(),
            title: Text("Repeat key for ${widget.nameController.text}"),
          ),
        );
      case WebsocketIrResponse.shortCode:
        return ElevatedButton(
          onPressed: () {},
          child: ListTile(
            leading: CircularProgressIndicator(),
            title: Text("Received short code, try again"),
          ),
        );
      case WebsocketIrResponse.done:
        return Text("Done! Command ${widget.nameController.text} created!");
      case WebsocketIrResponse.cancelled || WebsocketIrResponse.tooManyRetries:
        return ElevatedButton(
          onPressed: _connectToSocket,
          child: ListTile(
            leading: CircularProgressIndicator(),
            title: Text("Recording cancelled by the server, try again?"),
          ),
        );
    }
  }
}
