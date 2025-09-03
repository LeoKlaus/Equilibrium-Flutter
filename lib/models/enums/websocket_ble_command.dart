import 'package:json_annotation/json_annotation.dart';

enum WebsocketBleCommand {
  @JsonValue("advertise") advertise,
  @JsonValue("connect") connect,
  @JsonValue("disconnect") disconnect,
  @JsonValue("devices") devices
}