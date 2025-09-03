import 'package:equilibrium_flutter/models/classes/scene.dart';
import 'package:equilibrium_flutter/models/enums/scene_status.dart';
import 'package:equilibrium_flutter/models/classes/device_states.dart';

import 'package:json_annotation/json_annotation.dart';

part 'status_report.g.dart';

@JsonSerializable()
class StatusReport {
  @JsonKey(name: 'current_scene')
  Scene? currentScene;
  @JsonKey(name: 'scene_status')
  SceneStatus? sceneStatus;
  DeviceStates? devices;

  StatusReport({this.currentScene, this.sceneStatus, this.devices});

  factory StatusReport.fromJson(Map<String, dynamic> json) =>
      _$StatusReportFromJson(json);

  Map<String, dynamic> toJson() => _$StatusReportToJson(this);
}
