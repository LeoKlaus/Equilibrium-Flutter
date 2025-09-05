import 'package:equilibrium_flutter/models/classes/command.dart';
import 'package:equilibrium_flutter/models/classes/device.dart';
import 'package:equilibrium_flutter/models/classes/scene.dart';

import 'package:json_annotation/json_annotation.dart';

part 'macro.g.dart';

@JsonSerializable()
class Macro {
  @JsonKey(includeToJson: false)
  int? id;
  String? name;
  @JsonKey(includeToJson: false)
  List<Command>? commands;
  @JsonKey(name: "command_ids")
  List<int>? commandIds;
  List<int> delays;
  @JsonKey(includeToJson: false)
  List<Scene>? scenes;
  @JsonKey(includeToJson: false)
  List<Device>? devices;

  Macro({
    this.id,
    this.name,
    this.commands,
    List<int>? delays,
    this.scenes,
    this.devices,
  }) : delays = delays ?? [];

  factory Macro.fromJson(Map<String, dynamic> json) => _$MacroFromJson(json);

  Map<String, dynamic> toJson() => _$MacroToJson(this);
}
