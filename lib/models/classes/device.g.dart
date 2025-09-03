// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String? ?? "",
  manufacturer: json['manufacturer'] as String?,
  model: json['model'] as String?,
  type:
      $enumDecodeNullable(_$DeviceTypeEnumMap, json['type']) ??
      DeviceType.other,
  bluetoothAddress: json['bluetooth_address'] as String?,
  imageId: (json['image_id'] as num?)?.toInt(),
  image:
      json['image'] == null
          ? null
          : UserImage.fromJson(json['image'] as Map<String, dynamic>),
  commands:
      (json['commands'] as List<dynamic>?)
          ?.map((e) => Command.fromJson(e as Map<String, dynamic>))
          .toList(),
  scenes:
      (json['scenes'] as List<dynamic>?)
          ?.map((e) => Scene.fromJson(e as Map<String, dynamic>))
          .toList(),
  macros:
      (json['macros'] as List<dynamic>?)
          ?.map((e) => Macro.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'manufacturer': instance.manufacturer,
  'model': instance.model,
  'type': _$DeviceTypeEnumMap[instance.type]!,
  'bluetooth_address': instance.bluetoothAddress,
  'image_id': instance.imageId,
  'image': instance.image,
  'commands': instance.commands,
  'scenes': instance.scenes,
  'macros': instance.macros,
};

const _$DeviceTypeEnumMap = {
  DeviceType.display: 'display',
  DeviceType.amplifier: 'amplifier',
  DeviceType.player: 'player',
  DeviceType.integration: 'integration',
  DeviceType.other: 'other',
};
