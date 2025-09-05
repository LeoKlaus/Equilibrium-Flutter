import 'package:equilibrium_flutter/views/subviews/color_inverted.dart';
import 'package:equilibrium_flutter/views/subviews/tappable_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/hub_connection_handler.dart';
import '../../models/classes/status_report.dart';
import '../../models/classes/scene.dart';
import '../subviews/status_injected.dart';

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
  }

  Future<void> _refresh() async {
    List<Scene> scenes = await connectionHandler.getScenes();
    setState(() {
      scenesFuture = Future.value(scenes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scenes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).go("/scenes/create", extra: _refresh);
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: FutureBuilder<List<Scene>>(
          future: scenesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final scenes = snapshot.data!;
              return buildScenes(scenes);
            } else if (snapshot.hasError) {
              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  spacing: 20,
                  children: [
                    Text("Error: ${snapshot.error}"),
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
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  Widget buildScenes(List<Scene> scenes) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 72),
        itemCount: scenes.length,
        itemBuilder: (context, index) {
          final scene = scenes[index];
          return TappableCard(
            onTap: () {
              GoRouter.of(context).go("/scenes/${scene.id}");
            },
            leadingTile: StatusInjected(
              sceneId: scene.id,
              sceneActiveWidget: CircleAvatar(
                backgroundColor: Colors.green,
                child: Center(
                  child: Icon(
                    color: Colors.black,
                    Icons.power_settings_new,
                    size: 32,
                  ),
                ),
              ),
              sceneInactiveWidget: (scene.image?.id == null
                  ? CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Center(child: Text(scene.name.substring(0, 1))),
                    )
                  : ColorInverted(
                      child: Image.network(
                        height: 40,
                        width: 40,
                        "http://192.168.27.51:8000/images/${scene.image?.id}",
                      ),
                    )),
              transitionWidget: CircularProgressIndicator(),
            ),
            title: scene.name,
            subTitle:
                scene.devices
                    ?.map((device) => device.name)
                    .toList()
                    .join(" - ") ??
                "",
            trailingTile: StatusInjected(
              sceneId: scene.id,
              sceneActiveWidget: ElevatedButton(
                child: Text('Stop'),
                onPressed: () {
                  connectionHandler.stopCurrentScene();
                },
              ),
              sceneInactiveWidget: ElevatedButton(
                child: Text('Start'),
                onPressed: () {
                  connectionHandler.startScene(scene.id!);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
