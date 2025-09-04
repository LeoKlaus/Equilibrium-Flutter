import 'package:equilibrium_flutter/models/enums/remote_button.dart';
import 'package:equilibrium_flutter/models/enums/command_type.dart';
import 'package:equilibrium_flutter/models/enums/command_group_type.dart';
import 'package:equilibrium_flutter/models/classes/device.dart';
import 'package:equilibrium_flutter/models/enums/network_request_type.dart';
import 'package:equilibrium_flutter/models/classes/macro.dart';

import "package:json_annotation/json_annotation.dart";

part 'command.g.dart';

@JsonSerializable()
class Command {
  @JsonKey(includeToJson: false)
  int? id;
  String name;
  RemoteButton button;
  CommandType type;
  @JsonKey(name: 'command_group')
  CommandGroupType commandGroup;
  @JsonKey(name: 'device_id', includeToJson: false)
  int? _deviceId;
  @JsonKey(name: "device_id", includeFromJson: false, includeToJson: true)
  int? get deviceId => device?.id ?? _deviceId;
  @JsonKey(includeToJson: false)
  Device? device;
  String? host;
  NetworkRequestType? method;
  String? body;
  @JsonKey(name: 'bt_action')
  String? btAction;
  @JsonKey(name: 'bt_media_action')
  String? btMediaAction;
  @JsonKey(includeToJson: false)
  List<Macro>? macros;

  Command({
    this.id,
    this.name = "",
    this.button = RemoteButton.other,
    this.type = CommandType.infrared,
    this.commandGroup = CommandGroupType.other,
    deviceId,
    this.device,
    this.host,
    this.method,
    this.body,
    this.btAction,
    this.btMediaAction,
    this.macros,
  }): _deviceId = deviceId;

  factory Command.fromJson(Map<String, dynamic> json) =>
      _$CommandFromJson(json);

  Map<String, dynamic> toJson() => _$CommandToJson(this);
}
