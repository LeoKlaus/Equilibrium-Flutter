// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_states.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceState _$DeviceStateFromJson(Map<String, dynamic> json) => DeviceState(
  powered: json['powered'] as bool? ?? false,
  input: (json['input'] as num?)?.toInt(),
);

Map<String, dynamic> _$DeviceStateToJson(DeviceState instance) =>
    <String, dynamic>{'powered': instance.powered, 'input': instance.input};

DeviceStates _$DeviceStatesFromJson(Map<String, dynamic> json) => DeviceStates(
  states: (json['states'] as Map<String, dynamic>?)?.map(
    (k, e) =>
        MapEntry(int.parse(k), DeviceState.fromJson(e as Map<String, dynamic>)),
  ),
);

Map<String, dynamic> _$DeviceStatesToJson(DeviceStates instance) =>
    <String, dynamic>{
      'states': instance.states.map((k, e) => MapEntry(k.toString(), e)),
    };
