// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Command _$CommandFromJson(Map<String, dynamic> json) => Command(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String? ?? "",
  button:
      $enumDecodeNullable(_$RemoteButtonEnumMap, json['button']) ??
      RemoteButton.other,
  type:
      $enumDecodeNullable(_$CommandTypeEnumMap, json['type']) ??
      CommandType.infrared,
  commandGroup:
      $enumDecodeNullable(_$CommandGroupTypeEnumMap, json['command_group']) ??
      CommandGroupType.other,
  device: json['device'] == null
      ? null
      : Device.fromJson(json['device'] as Map<String, dynamic>),
  host: json['host'] as String?,
  method: $enumDecodeNullable(_$NetworkRequestTypeEnumMap, json['method']),
  body: json['body'] as String?,
  btAction: json['bt_action'] as String?,
  btMediaAction: json['bt_media_action'] as String?,
  macros: (json['macros'] as List<dynamic>?)
      ?.map((e) => Macro.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CommandToJson(Command instance) => <String, dynamic>{
  'name': instance.name,
  'button': _$RemoteButtonEnumMap[instance.button]!,
  'type': _$CommandTypeEnumMap[instance.type]!,
  'command_group': _$CommandGroupTypeEnumMap[instance.commandGroup]!,
  'device_id': instance.deviceId,
  'host': instance.host,
  'method': _$NetworkRequestTypeEnumMap[instance.method],
  'body': instance.body,
  'bt_action': instance.btAction,
  'bt_media_action': instance.btMediaAction,
};

const _$RemoteButtonEnumMap = {
  RemoteButton.powerToggle: 'power_toggle',
  RemoteButton.powerOff: 'power_off',
  RemoteButton.powerOn: 'power_on',
  RemoteButton.volumeUp: 'volume_up',
  RemoteButton.volumeDown: 'volume_down',
  RemoteButton.mute: 'mute',
  RemoteButton.directionUp: 'direction_up',
  RemoteButton.directionDown: 'direction_down',
  RemoteButton.directionLeft: 'direction_left',
  RemoteButton.directionRight: 'direction_right',
  RemoteButton.select: 'select',
  RemoteButton.guide: 'guide',
  RemoteButton.info: 'info',
  RemoteButton.back: 'back',
  RemoteButton.menu: 'menu',
  RemoteButton.home: 'home',
  RemoteButton.exit: 'exit',
  RemoteButton.play: 'play',
  RemoteButton.pause: 'pause',
  RemoteButton.playpause: 'playpause',
  RemoteButton.stop: 'stop',
  RemoteButton.fastForward: 'fast_forward',
  RemoteButton.rewind: 'rewind',
  RemoteButton.nextTrack: 'next_track',
  RemoteButton.previousTrack: 'previous_track',
  RemoteButton.record: 'record',
  RemoteButton.channelUp: 'channel_up',
  RemoteButton.channelDown: 'channel_down',
  RemoteButton.green: 'green',
  RemoteButton.red: 'red',
  RemoteButton.blue: 'blue',
  RemoteButton.yellow: 'yellow',
  RemoteButton.numberZero: 'number_zero',
  RemoteButton.numberOne: 'number_one',
  RemoteButton.numberTwo: 'number_two',
  RemoteButton.numberThree: 'number_three',
  RemoteButton.numberFour: 'number_four',
  RemoteButton.numberFive: 'number_five',
  RemoteButton.numberSix: 'number_six',
  RemoteButton.numberSeven: 'number_seven',
  RemoteButton.numberEight: 'number_eight',
  RemoteButton.numberNine: 'number_nine',
  RemoteButton.brightnessUp: 'brightness_up',
  RemoteButton.brightnessDown: 'brightness_down',
  RemoteButton.turnOn: 'turn_on',
  RemoteButton.turnOff: 'turn_off',
  RemoteButton.other: 'other',
};

const _$CommandTypeEnumMap = {
  CommandType.infrared: 'ir',
  CommandType.bluetooth: 'bluetooth',
  CommandType.network: 'network',
  CommandType.script: 'script',
};

const _$CommandGroupTypeEnumMap = {
  CommandGroupType.power: 'power',
  CommandGroupType.volume: 'volume',
  CommandGroupType.navigation: 'navigation',
  CommandGroupType.transport: 'transport',
  CommandGroupType.channel: 'channel',
  CommandGroupType.numeric: 'numeric',
  CommandGroupType.input: 'input',
  CommandGroupType.coloredButtons: 'colored_buttons',
  CommandGroupType.other: 'other',
};

const _$NetworkRequestTypeEnumMap = {
  NetworkRequestType.get: 'get',
  NetworkRequestType.post: 'post',
  NetworkRequestType.patch: 'patch',
  NetworkRequestType.delete: 'delete',
  NetworkRequestType.head: 'head',
  NetworkRequestType.put: 'put',
};
