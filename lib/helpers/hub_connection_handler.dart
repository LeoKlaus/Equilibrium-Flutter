import 'dart:developer' as developer;
import 'dart:io';

import 'package:equilibrium_flutter/helpers/preference_handler.dart';
import 'package:equilibrium_flutter/models/classes/ble_device.dart';
import 'package:equilibrium_flutter/models/classes/scene.dart';
import 'package:equilibrium_flutter/models/classes/user_image.dart';
import 'package:equilibrium_flutter/repositories/api_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import '../models/classes/command.dart';
import '../models/classes/device.dart';

class NotConnectedException implements Exception {
  String errorMessage() {
    return "You're not connected to a hub.";
  }
}

class HubConnectionHandler {

  ApiRepository? api;

  HubConnectionHandler(String storedUri) {
    if (kIsWeb) {
      developer.log("Running web ui, connecting to local api", level: 0);
      api = ApiRepository(baseUri: "${Uri.base.host}:${Uri.base.port}");
    } else if (storedUri != "") {
      developer.log("Found stored url: $storedUri");
      api = ApiRepository(baseUri: storedUri);
    } else {
      developer.log("No URL was stored");
      api = null;
    }
  }

  Future<void> connect(String baseUri) async {
    final testApi = ApiRepository(baseUri: baseUri);
    await testApi.testConnection();
    final preferences = await StreamingSharedPreferences.instance;
    preferences.setString(PreferenceKeys.hubUrl, baseUri);
    api = testApi;
  }

  Future<List<Scene>> getScenes() async {
    final localApi = api;
    if (localApi != null) {
      return await localApi.getScenes();
    } else {
      throw NotConnectedException();
    }
  }

  Future<Scene> getScene(int id) async {
    final localApi = api;
    if (localApi != null) {
      return await localApi.getScene(id);
    } else {
      throw NotConnectedException();
    }
  }

  Future<void> startScene(int id) async {
    final localApi = api;
    if (localApi != null) {
      return await localApi.startScene(id);
    } else {
      throw NotConnectedException();
    }
  }

  Future<void> stopCurrentScene() async {
    final localApi = api;
    if (localApi != null) {
      return await localApi.stopCurrentScene();
    } else {
      throw NotConnectedException();
    }
  }

  Future<List<Device>> getDevices() async {
    final localApi = api;
    if (localApi != null) {
      return await localApi.getDevices();
    } else {
      throw NotConnectedException();
    }
  }

  Future<Device> getDevice(int id) async {
    final localApi = api;
    if (localApi != null) {
      return await localApi.getDevice(id);
    } else {
      throw NotConnectedException();
    }
  }

  Future<List<UserImage>> getImages() async {
    final localApi = api;
    if (localApi != null) {
      return await localApi.getImages();
    } else {
      throw NotConnectedException();
    }
  }

  Future<void> uploadImage(File image) async {
    final localApi = api;
    if (localApi != null) {
      return await localApi.uploadImage(image);
    } else {
      throw NotConnectedException();
    }
  }

  Future<void> uploadImageWeb(List<int> bytes, String path) async {
    final localApi = api;
    if (localApi != null) {
      return await localApi.uploadImageWeb(bytes, path);
    } else {
      throw NotConnectedException();
    }
  }

  Future<List<BleDevice>> getBleDevices() async {
    final localApi = api;
    if (localApi != null) {
      return await localApi.getBleDevices();
    } else {
      throw NotConnectedException();
    }
  }

  Future<List<Command>> getCommands() async {
    final localApi = api;
    if (localApi != null) {
      return await localApi.getCommands();
    } else {
      throw NotConnectedException();
    }
  }

  Future<Command> createCommand(Command newCommand) async {
    final localApi = api;
    if (localApi != null) {
      return await localApi.createCommand(newCommand);
    } else {
      throw NotConnectedException();
    }
  }
}