import 'dart:developer' as developer;
import 'dart:io';

import 'package:equilibrium_flutter/models/classes/ble_device.dart';
import 'package:equilibrium_flutter/models/classes/command.dart';
import 'package:equilibrium_flutter/models/classes/device.dart';
import 'package:equilibrium_flutter/models/classes/macro.dart';
import 'package:equilibrium_flutter/models/classes/scene.dart';
import 'package:equilibrium_flutter/models/classes/server_info.dart';
import 'package:equilibrium_flutter/models/classes/status_report.dart';
import 'package:equilibrium_flutter/models/classes/user_image.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class InvalidResponseException implements Exception {

  final int statusCode;
  final String? body;

  InvalidResponseException({required this.statusCode,  this.body});

  String errorMessage() {
    if (body != null) {
      return "Received an invalid response from the server: $statusCode\n$body";
    } else {
      return "Received an invalid response from the server: $statusCode";
    }
  }
}

class ApiRepository {
  String baseUri;

  ApiRepository({required this.baseUri});

  ValueNotifier<StatusReport?> statusNotifier = ValueNotifier(null);

  WebSocketChannel? _socket;

  void connectToStatusSocket() {
    _socket = WebSocketChannel.connect(Uri.parse('ws://$baseUri/ws/status'));
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
    final uri = Uri.http(baseUri, "/macros");
    final response = await http.get(uri);
    final List body = json.decode(response.body);
    return body.map((e) => Macro.fromJson(e)).toList();
  }

  Future<List<UserImage>> getImages() async {
    final uri = Uri.http(baseUri, "/images");
    final response = await http.get(uri);
    final List body = json.decode(response.body);
    return body.map((e) => UserImage.fromJson(e)).toList();
  }

  Future<void> uploadImage(File image) async {
    final uri = Uri.http(baseUri, "/images/");
    var request = http.MultipartRequest("POST", uri);
    final type = ContentType.parse(image.path);
    request.files.add(
      http.MultipartFile(
        "file",
        image.openRead(),
        await image.length(),
        filename: basename(image.path),
        contentType: MediaType(type.primaryType, type.subType),
      ),
    );

    final response = await request.send();
    developer.log("Server responded ${response.statusCode} to file upload");
  }

  Future<void> uploadImageWeb(List<int> bytes, String path) async {
    final uri = Uri.http(baseUri, "/images/");
    var request = http.MultipartRequest("POST", uri);
    request.files.add(
      http.MultipartFile.fromBytes("file", bytes, filename: basename(path)),
    );

    final response = await request.send();
    developer.log("Server responded ${response.statusCode} to file upload");
  }

  Future<void> deleteImage(int id) async {
    final uri = Uri.http(baseUri, "/images/$id");
    await http.delete(uri);
  }

  Future<List<BleDevice>> getBleDevices() async {
    final uri = Uri.http(baseUri, "/bluetooth/devices");
    final response = await http.get(uri);
    final List body = json.decode(response.body);
    return body.map((e) => BleDevice.fromJson(e)).toList();
  }

  Future<void> connectBleDevice(String address) async {
    final uri = Uri.http(baseUri, "/bluetooth/connect/$address");
    await http.post(uri);
  }

  Future<void> disconnectBleDevices() async {
    final uri = Uri.http(baseUri, "/bluetooth/disconnect");
    await http.post(uri);
  }

  Future<void> advertiseBle() async {
    final uri = Uri.http(baseUri, "/bluetooth/start_advertisement");
    await http.post(uri);
  }

  Future<void> pairDevices() async {
    final uri = Uri.http(baseUri, "/bluetooth/start_pairing");
    await http.post(uri);
  }

  Future<void> sendCommand(int id) async {
    final uri = Uri.http(baseUri, "/commands/$id/send");
    await http.post(uri);
  }

  Future<void> deleteCommand(int id) async {
    final uri = Uri.http(baseUri, "/commands/$id");
    await http.delete(uri);
  }
  
  Future<Command> createCommand(Command newCommand) async {
    final uri = Uri.http(baseUri, "/commands/");
    final response = await http.post(uri, headers: {"Content-Type": "application/json"}, body: jsonEncode(newCommand));
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final body = json.decode(response.body);
      return Command.fromJson(body);
    } else {
      throw InvalidResponseException(statusCode: response.statusCode, body: response.body);
    }
  }

  Future<void> deleteMacro(int id) async {
    final uri = Uri.http(baseUri, "/macros/$id");
    await http.delete(uri);
  }

  Future<void> deleteDevice(int id) async {
    final uri = Uri.http(baseUri, "/devices/$id");
    await http.delete(uri);
  }

  Future<void> executeMacro(int id) async {
    final uri = Uri.http(baseUri, "/macros/$id/execute");
    await http.post(uri);
  }

  Future<Macro> createMacro(Macro newMacro) async {
    final uri = Uri.http(baseUri, "/macros/");
    final response = await http.post(uri, headers: {"Content-Type": "application/json"}, body: jsonEncode(newMacro));
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final body = json.decode(response.body);
      return Macro.fromJson(body);
    } else {
      throw InvalidResponseException(statusCode: response.statusCode, body: response.body);
    }
  }

  Future<Macro> updateMacro(int id, Macro newMacro) async {
    final uri = Uri.http(baseUri, "/macros/$id");
    final response = await http.patch(uri, headers: {"Content-Type": "application/json"}, body: jsonEncode(newMacro));
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final body = json.decode(response.body);
      return Macro.fromJson(body);
    } else {
      throw InvalidResponseException(statusCode: response.statusCode, body: response.body);
    }
  }

  Future<Device> createDevice(Device newDevice) async {
    final uri = Uri.http(baseUri, "/devices/");
    final response = await http.post(uri, headers: {"Content-Type": "application/json"}, body: jsonEncode(newDevice));
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final body = json.decode(response.body);
      return Device.fromJson(body);
    } else {
      throw InvalidResponseException(statusCode: response.statusCode, body: response.body);
    }
  }

  Future<Device> updateDevice(int id, Device newDevice) async {
    final uri = Uri.http(baseUri, "/devices/$id");
    final response = await http.patch(uri, headers: {"Content-Type": "application/json"}, body: jsonEncode(newDevice));
    print("sent: ${jsonEncode(newDevice)}");
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final body = json.decode(response.body);
      return Device.fromJson(body);
    } else {
      throw InvalidResponseException(statusCode: response.statusCode, body: response.body);
    }
  }
}
