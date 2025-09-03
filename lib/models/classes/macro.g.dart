// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'macro.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Macro _$MacroFromJson(Map<String, dynamic> json) => Macro(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  commands:
      (json['commands'] as List<dynamic>?)
          ?.map((e) => Command.fromJson(e as Map<String, dynamic>))
          .toList(),
  delays:
      (json['delays'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
  scenes:
      (json['scenes'] as List<dynamic>?)
          ?.map((e) => Scene.fromJson(e as Map<String, dynamic>))
          .toList(),
  devices:
      (json['devices'] as List<dynamic>?)
          ?.map((e) => Device.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$MacroToJson(Macro instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'commands': instance.commands,
  'delays': instance.delays,
  'scenes': instance.scenes,
  'devices': instance.devices,
};
