// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scene _$SceneFromJson(Map<String, dynamic> json) => Scene(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String? ?? "",
  devices: (json['devices'] as List<dynamic>?)
      ?.map((e) => Device.fromJson(e as Map<String, dynamic>))
      .toList(),
  imageId: (json['image_id'] as num?)?.toInt(),
  image: json['image'] == null
      ? null
      : UserImage.fromJson(json['image'] as Map<String, dynamic>),
  startMacro: json['start_macro'] == null
      ? null
      : Macro.fromJson(json['start_macro'] as Map<String, dynamic>),
  stopMacro: json['stop_macro'] == null
      ? null
      : Macro.fromJson(json['stop_macro'] as Map<String, dynamic>),
  macros: (json['macros'] as List<dynamic>?)
      ?.map((e) => Macro.fromJson(e as Map<String, dynamic>))
      .toList(),
  bluetoothAddress: json['bluetooth_address'] as String?,
  keymap: json['keymap'] as String?,
);

Map<String, dynamic> _$SceneToJson(Scene instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'device_ids': instance.deviceIds,
  'image_id': instance.imageId,
  'start_macro_id': instance.startMacroId,
  'stop_macro_id': instance.stopMacroId,
  'macro_ids': instance.macroIds,
  'bluetooth_address': instance.bluetoothAddress,
  'keymap': instance.keymap,
};
