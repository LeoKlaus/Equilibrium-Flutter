import 'package:equilibrium_flutter/models/classes/command.dart';
import 'package:equilibrium_flutter/models/classes/device.dart';
import 'package:equilibrium_flutter/models/classes/macro.dart';
import 'package:equilibrium_flutter/models/classes/scene.dart';
import 'package:equilibrium_flutter/models/classes/server_info.dart';
import 'package:equilibrium_flutter/models/classes/status_report.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/cupertino.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiRepository {
  String baseUri;

  ApiRepository({required this.baseUri});

  ValueNotifier<StatusReport?> statusNotifier = ValueNotifier(null);

  WebSocketChannel? _socket;

  void connectToStatusSocket() {
    _socket = WebSocketChannel.connect(
      Uri.parse('ws://$baseUri/ws/status'),
    );
    _socket?.stream.listen(_handleSocketUpdate);
  }

  void disconnectFromStatusSocket() {
    _socket?.sink.close();
  }

  void _handleSocketUpdate(dynamic value) {
    final body = json.decode(value);
    statusNotifier.value = StatusReport.fromJson(body);
  }

  Future<ServerInfo> testConnection() async {
    final uri = Uri.http(baseUri, "/info");
    final response = await http.get(uri);
    final body = json.decode(response.body);
    return ServerInfo.fromJson(body);
  }
  
  Future<List<Device>> getDevices() async {
    final uri = Uri.http(baseUri, "/devices");
    final response = await http.get(uri);
    final List body = json.decode(response.body);
    return body.map((e) => Device.fromJson(e)).toList();
  }

  Future<Device> getDevice(int id) async {
    final uri = Uri.http(baseUri, "/devices/$id");
    final response = await http.get(uri);
    final body = json.decode(response.body);
    return Device.fromJson(body);
  }

  Future<List<Scene>> getScenes() async {
    final uri = Uri.http(baseUri, "/scenes");
    final response = await http.get(uri);
    final List body = json.decode(response.body);
    return body.map((e) => Scene.fromJson(e)).toList();
  }

  Future<Scene> getScene(int id) async {
    final uri = Uri.http(baseUri, "/scenes/$id");
    final response = await http.get(uri);
    final body = json.decode(response.body);
    return Scene.fromJson(body);
  }

  Future<void> startScene(int id) async {
    var url = Uri.http(baseUri, "/scenes/$id/start");
    await http.post(url, headers: {"Content-Type": "application/json"});
  }

  Future<void> stopCurrentScene() async {
    var url = Uri.http(baseUri, "/scenes/stop");
    await http.post(url, headers: {"Content-Type": "application/json"});
  }

  Future<List<Command>> getCommands() async {
    final uri = Uri.http(baseUri, "/commands");
    final response = await http.get(uri);
    final List body = json.decode(response.body);
    return body.map((e) => Command.fromJson(e)).toList();
  }

  Future<List<Macro>> getMacros() async {
    final uri = Uri.http(baseUri, "/commands");
    final response = await http.get(uri);
    final List body = json.decode(response.body);
    return body.map((e) => Macro.fromJson(e)).toList();
  }
}
