import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../HubConnectionHandler.dart';
import '../../models/classes/device.dart';
import '../../models/classes/status_report.dart';
import '../../models/classes/scene.dart';
import '../../models/enums/scene_status.dart';

class SceneList extends StatefulWidget {
  const SceneList({super.key});

  @override
  State<SceneList> createState() => _SceneListState();
}

class _SceneListState extends State<SceneList> {

  final HubConnectionHandler connectionHandler =
      GetIt.instance<HubConnectionHandler>();

  late Future<List<Scene>> scenesFuture;

  StatusReport? status;

  @override
  void initState() {
    super.initState();
    scenesFuture = connectionHandler.getScenes();
    //loadScenes();
  }

  void loadScenes() async {
    try {
      final scenes = await connectionHandler.getScenes();
    } on NotConnectedException {
      print("Received not connected while fetching scenes");
      if (mounted) context.go("/connect");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Scene>>(
          future: scenesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final scenes = snapshot.data!;
              return buildScenes(scenes);
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  Widget buildScenes(List<Scene> scenes) {
    return ListView.builder(
      itemCount: scenes.length,
      itemBuilder: (context, index) {
        final scene = scenes[index];
        return Card(
          margin: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ValueListenableBuilder<StatusReport?>(
                  valueListenable: connectionHandler.api!.statusNotifier,
                  builder: (BuildContext context, StatusReport? status, child) {
                    return ListTile(
                      leading:
                          status?.currentScene?.id == scene.id
                              ? (status?.sceneStatus == SceneStatus.active
                                  ? CircleAvatar(
                                    backgroundColor: Colors.lightGreen,
                                    child: Center(
                                      child: Icon(
                                        Icons.power_settings_new,
                                        size: 32,
                                      ),
                                    ),
                                  )
                                  : CircularProgressIndicator())
                              : (scene.image?.id == null
                                  ? CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    child: Center(
                                      child: Text(scene.name.substring(0, 1)),
                                    ),
                                  )
                                  : Image.network(
                                    "http://192.168.27.51:8000/images/${scene.image?.id}",
                                  )),
                      title: Text(scene.name),
                      subtitle: Text(
                        scene.devices
                                ?.map((device) => device.name)
                                .toList()
                                .join(" - ") ??
                            "",
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                      trailing:
                          status?.currentScene?.id == scene.id
                              ? ElevatedButton(
                                child: Text('Stop'),
                                onPressed: () {
                                  connectionHandler.stopCurrentScene();
                                },
                              )
                              : ElevatedButton(
                                child: Text('Start'),
                                onPressed: () {
                                  connectionHandler.startScene(scene.id!);
                                },
                              ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/*class SceneList extends StatefulWidget {
  const SceneList({super.key});

  @override
  State<SceneList> createState() => _SceneListState();
}

class _SceneListState extends State<SceneList> {

  final HubConnectionHandler connectionHandler =
  GetIt.instance<HubConnectionHandler>();

  late Future<List<Device>> devicesFuture;

  _SceneListState();

  @override
  void initState() {
    super.initState();
    try {
      devicesFuture = connectionHandler.getDevices();
    } on NotConnectedException {
      print("Received not connected while fetching devices");
      context.go("/connect");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Device>>(
          future: devicesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final devices = snapshot.data!;
              return buildDevices(devices);
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  Widget buildDevices(List<Device> devices) {
    return ListView.builder(
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return GestureDetector(
          onTap: () {
            GoRouter.of(context).go("/devices/${device.id}");
          },
          child: Card(
            margin: EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    leading:
                    device.imageId == null
                        ? Icon(device.type.icon, size: 32)
                        : Image.network(
                      "http://${connectionHandler.api?.baseUri ?? ""}/images/${device.imageId}",
                    ),
                    title: Text(device.name),
                    subtitle:
                    device.manufacturer == null
                        ? Text(
                      device.model ?? "",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    )
                        : Text(
                      "${device.manufacturer ?? ""} ${device.model ?? ""}",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
*/