import 'package:json_annotation/json_annotation.dart';

enum CommandType {
  @JsonValue("ir") infrared,
  @JsonValue("bluetooth") bluetooth,
  @JsonValue("network") network,
  @JsonValue("script") script
}