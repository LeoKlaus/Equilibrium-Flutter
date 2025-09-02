import 'package:json_annotation/json_annotation.dart';

enum CommandGroupType {
  @JsonValue("volume") volume,
  @JsonValue("navigation") navigation,
  @JsonValue("transport") transport,
  @JsonValue("colored_buttons") coloredButtons,
  @JsonValue("channel") channel,
  @JsonValue("power") power,
  @JsonValue("numeric") numeric,
  @JsonValue("input") input,
  @JsonValue("other") other
}