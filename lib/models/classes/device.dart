import 'package:equilibrium_flutter/models/enums/device_type.dart';
import 'package:equilibrium_flutter/models/classes/user_image.dart';
import 'package:equilibrium_flutter/models/classes/command.dart';
import 'package:equilibrium_flutter/models/classes/scene.dart';
import 'package:equilibrium_flutter/models/classes/macro.dart';
import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

@JsonSerializable()
class Device {
  @JsonKey(includeToJson: false)
  int? id;
  String name = "";
  String? manufacturer;
  String? model;
  DeviceType type = DeviceType.other;
  @JsonKey(name: 'bluetooth_address')
  String? bluetoothAddress;
  @JsonKey(name: 'image_id')
  int? imageId;
  @JsonKey(includeToJson: false)
  UserImage? image;
  @JsonKey(includeToJson: false)
  List<Command>? commands;
  @JsonKey(includeToJson: false)
  List<Scene>? scenes;
  @JsonKey(includeToJson: false)
  List<Macro>? macros;

  Device({
    this.id,
    this.name = "",
    this.manufacturer,
    this.model,
    this.type = DeviceType.other,
    this.bluetoothAddress,
    this.imageId,
    this.image,
    this.commands,
    this.scenes,
    this.macros,
  });

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);

  DropdownMenuEntry<Device> toDropDownMenuEntry() {
    return DropdownMenuEntry(value: this, label: name);
  }
}
