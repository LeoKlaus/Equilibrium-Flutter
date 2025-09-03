import 'package:json_annotation/json_annotation.dart';

part 'device_states.g.dart';

@JsonSerializable()
class DeviceState {
  bool powered;
  int? input;

  DeviceState({this.powered = false, this.input});

  factory DeviceState.fromJson(Map<String, dynamic> json) =>
      _$DeviceStateFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceStateToJson(this);
}

@JsonSerializable()
class DeviceStates {
  Map<int, DeviceState> states = {};

  DeviceStates({Map<int, DeviceState>? states}) : states = states ?? {};

  factory DeviceStates.fromJson(Map<String, dynamic> json) =>
      _$DeviceStatesFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceStatesToJson(this);
}
