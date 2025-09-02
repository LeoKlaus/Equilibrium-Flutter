import 'package:equilibrium_flutter/models/classes/device.dart';
import 'package:equilibrium_flutter/models/classes/user_image.dart';
import 'package:equilibrium_flutter/models/classes/macro.dart';

import 'package:json_annotation/json_annotation.dart';

part 'scene.g.dart';

@JsonSerializable()
class Scene {
  int? id;
  String name;
  List<Device>? devices;
  @JsonKey(name: 'image_id')
  int? imageId;
  UserImage? image;
  @JsonKey(name: 'start_macro')
  Macro? startMacro;
  @JsonKey(name: 'stop_macro')
  Macro? stopMacro;
  List<Macro>? macros;
  @JsonKey(name: 'bluetooth_address')
  String? bluetoothAddress;
  String? keymap;

  Scene({
    this.id,
    this.name = "",
    this.devices,
    this.imageId,
    this.image,
    this.startMacro,
    this.stopMacro,
    this.macros,
    this.bluetoothAddress,
    this.keymap,
  });

  factory Scene.fromJson(Map<String, dynamic> json) => _$SceneFromJson(json);

  Map<String, dynamic> toJson() => _$SceneToJson(this);
}
