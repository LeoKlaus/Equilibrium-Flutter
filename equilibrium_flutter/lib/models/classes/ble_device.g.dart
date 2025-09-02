// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ble_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BleDevice _$BleDeviceFromJson(Map<String, dynamic> json) => BleDevice(
  name: json['name'] as String? ?? "",
  address: json['address'] as String? ?? "",
  connected: json['connected'] as bool? ?? false,
  paired: json['paired'] as bool? ?? false,
);

Map<String, dynamic> _$BleDeviceToJson(BleDevice instance) => <String, dynamic>{
  'name': instance.name,
  'address': instance.address,
  'connected': instance.connected,
  'paired': instance.paired,
};
