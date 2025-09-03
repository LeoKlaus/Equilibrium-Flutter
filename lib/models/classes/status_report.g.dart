// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusReport _$StatusReportFromJson(Map<String, dynamic> json) => StatusReport(
  currentScene:
      json['current_scene'] == null
          ? null
          : Scene.fromJson(json['current_scene'] as Map<String, dynamic>),
  sceneStatus: $enumDecodeNullable(_$SceneStatusEnumMap, json['scene_status']),
  devices:
      json['devices'] == null
          ? null
          : DeviceStates.fromJson(json['devices'] as Map<String, dynamic>),
);

Map<String, dynamic> _$StatusReportToJson(StatusReport instance) =>
    <String, dynamic>{
      'current_scene': instance.currentScene,
      'scene_status': _$SceneStatusEnumMap[instance.sceneStatus],
      'devices': instance.devices,
    };

const _$SceneStatusEnumMap = {
  SceneStatus.starting: 'starting',
  SceneStatus.active: 'active',
  SceneStatus.stopping: 'stopping',
};
