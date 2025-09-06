import 'dart:developer' as developer;

import 'package:equilibrium_flutter/views/subviews/common_controls.dart';
import 'package:equilibrium_flutter/views/subviews/status_injected.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../helpers/hub_connection_handler.dart';
import '../../models/classes/scene.dart';

class SceneDetailScreen extends StatefulWidget {
  final int sceneId;

  const SceneDetailScreen({super.key, required this.sceneId});

  @override
  State<SceneDetailScreen> createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<SceneDetailScreen> {
  late Future<Scene> sceneFuture;

  final HubConnectionHandler connectionHandler =
      GetIt.instance<HubConnectionHandler>();

  _DeviceDetailScreenState();

  @override
  void initState() {
    super.initState();
    sceneFuture = connectionHandler.getScene(widget.sceneId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          FutureBuilder(
            future: sceneFuture,
            builder: (context, snapshot) {
              return Row(
                children: [
                  StatusInjected(
                    sceneId: snapshot.data?.id,
                    sceneActiveWidget: IconButton(
                      onPressed: () {
                        final sceneId = snapshot.data?.id;
                        if (sceneId != null) {
                          connectionHandler.startScene(sceneId);
                        } else {
                          developer.log("Couldn't get scene id");
                        }
                      },
                      icon: Icon(Icons.power_settings_new, color: Colors.red),
                    ),
                    sceneInactiveWidget: IconButton(
                      onPressed: () {
                        connectionHandler.stopCurrentScene();
                      },
                      icon: Icon(Icons.power_settings_new, color: Colors.green),
                    ),
                    transitionWidget: CircularProgressIndicator(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<Scene>(
          future: sceneFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final scene = snapshot.data!;
              return buildScene(scene);
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  Widget buildScene(Scene scene) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
      child: CommonControls(devices: scene.devices ?? []),
    );
  }
}
