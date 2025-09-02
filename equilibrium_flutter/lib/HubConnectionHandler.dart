import 'package:equilibrium_flutter/models/classes/scene.dart';
import 'package:equilibrium_flutter/repositories/api_repository.dart';
import 'package:flutter/cupertino.dart';

import 'models/classes/device.dart';

class NotConnectedException implements Exception {
  String errorMessage() {
    return "You're not connected to a hub.";
  }
}

class HubConnectionHandler {
  ApiRepository? api;

  Future<void> connect(String baseUri) async {
    final testApi = ApiRepository(baseUri: baseUri);
    final info = await testApi.testConnection();
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
}