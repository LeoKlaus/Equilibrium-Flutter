import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../HubConnectionHandler.dart';
import '../../models/classes/device.dart';
import '../../models/classes/scene.dart';

class SceneDetailScreen extends StatefulWidget {
  final int sceneId;

  const SceneDetailScreen ({ super.key, required this.sceneId });

  @override
  State<SceneDetailScreen> createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<SceneDetailScreen> {

  late Future<Scene> sceneFuture;

  final HubConnectionHandler connectionHandler = GetIt.instance<HubConnectionHandler>();

  _DeviceDetailScreenState();

  @override
  void initState() {
    super.initState();
    try {
      sceneFuture = connectionHandler.getScene(widget.sceneId);
    } on NotConnectedException {
      context.go("/connect");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    return Text(scene.name);
  }
}
