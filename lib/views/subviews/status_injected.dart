import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../helpers/hub_connection_handler.dart';
import '../../models/classes/status_report.dart';
import '../../models/enums/scene_status.dart';

class StatusInjected extends StatefulWidget {
  final int? sceneId;
  final Widget sceneActiveWidget;
  final Widget sceneInactiveWidget;
  final Widget? transitionWidget;

  const StatusInjected({
    super.key,
    required this.sceneId,
    required this.sceneActiveWidget,
    required this.sceneInactiveWidget,
    this.transitionWidget,
  });

  @override
  State<StatefulWidget> createState() => _StatusInjectedState();
}

class _StatusInjectedState extends State<StatusInjected> {
  final HubConnectionHandler connectionHandler =
      GetIt.instance<HubConnectionHandler>();

  StatusReport? status;

  @override
  void initState() {
    super.initState();
    connectionHandler.api?.connectToStatusSocket();
  }

  @override
  void dispose() {
    connectionHandler.api?.disconnectFromStatusSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<StatusReport?>(
      valueListenable: connectionHandler.api!.statusNotifier,
      builder: (BuildContext context, StatusReport? status, child) {
        if (status?.currentScene?.id == widget.sceneId) {
          if (status?.sceneStatus == SceneStatus.active) {
            return widget.sceneActiveWidget;
          } else if (widget.transitionWidget != null) {
            return widget.transitionWidget!;
          } else {
            return widget.sceneInactiveWidget;
          }
        } else {
          return widget.sceneInactiveWidget;
        }
      },
    );
  }
}
