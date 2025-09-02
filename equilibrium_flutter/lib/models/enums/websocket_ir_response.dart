import 'package:json_annotation/json_annotation.dart';

enum WebsocketIrResponse {
  @JsonValue("press_key") pressKey,
  @JsonValue("repeat_key") repeatKey,
  @JsonValue("short_code") shortCode,
  @JsonValue("done") done,
  @JsonValue("cancelled") cancelled,
  @JsonValue("too_many_retries") tooManyRetries
}