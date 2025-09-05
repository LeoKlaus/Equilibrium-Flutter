import 'package:equilibrium_flutter/models/classes/device.dart';
import 'package:equilibrium_flutter/models/classes/user_image.dart';
import 'package:equilibrium_flutter/models/classes/macro.dart';

import 'package:json_annotation/json_annotation.dart';

part 'scene.g.dart';

@JsonSerializable()
class Scene {
  int? id;
  String name;
  @JsonKey(includeToJson: false)
  List<Device>? devices;
  @JsonKey(name: "device_ids", includeFromJson: false, includeToJson: true)
  List<int?>? get deviceIds => devices?.map((device) => device.id).toList();
  @JsonKey(name: 'image_id')
  int? imageId;
  @JsonKey(includeToJson: false)
  UserImage? image;
  @JsonKey(name: 'start_macro', includeToJson: false)
  Macro? startMacro;
  @JsonKey(name: "start_macro_id", includeFromJson: false, includeToJson: true)
  int? get startMacroId => startMacro?.id;
  @JsonKey(name: 'stop_macro', includeToJson: false)
  Macro? stopMacro;
  @JsonKey(name: "stop_macro_id", includeFromJson: false, includeToJson: true)
  int? get stopMacroId => stopMacro?.id;
  @JsonKey(includeToJson: false)
  List<Macro>? macros;
  @JsonKey(name: "macro_ids", includeFromJson: false, includeToJson: true)
  List<int?>? get macroIds => macros?.map((macro) => macro.id).toList();
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
