import 'package:equilibrium_flutter/models/classes/command.dart';
import 'package:equilibrium_flutter/models/classes/device.dart';
import 'package:equilibrium_flutter/models/classes/scene.dart';

import 'package:json_annotation/json_annotation.dart';

part 'macro.g.dart';

@JsonSerializable()
class Macro {
  int? id;
  String? name;
  List<Command>? commands;
  List<int> delays;
  List<Scene>? scenes;
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
