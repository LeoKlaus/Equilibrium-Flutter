import 'package:equilibrium_flutter/models/enums/device_type.dart';
import 'package:equilibrium_flutter/models/classes/user_image.dart';
import 'package:equilibrium_flutter/models/classes/command.dart';
import 'package:equilibrium_flutter/models/classes/scene.dart';
import 'package:equilibrium_flutter/models/classes/macro.dart';

import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

@JsonSerializable()
class Device {
  int? id;
  String name = "";
  String? manufacturer;
  String? model;
  DeviceType type = DeviceType.other;
  @JsonKey(name: 'bluetooth_address')
  String? bluetoothAddress;
  @JsonKey(name: 'image_id')
  int? imageId;
  UserImage? image;
  List<Command>? commands;
  List<Scene>? scenes;
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
}
