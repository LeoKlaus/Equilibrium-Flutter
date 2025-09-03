import 'package:json_annotation/json_annotation.dart';

enum SceneStatus {
  @JsonValue("starting") starting,
  @JsonValue("active") active,
  @JsonValue("stopping") stopping
}