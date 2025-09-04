import 'package:json_annotation/json_annotation.dart';

class DecodingException implements Exception {
  final String key;

  DecodingException({required this.key});

  String errorMessage() => "Couldn't decode key $key";
}

enum WebsocketIrResponse {
  @JsonValue("press_key")
  pressKey,
  @JsonValue("repeat_key")
  repeatKey,
  @JsonValue("short_code")
  shortCode,
  @JsonValue("done")
  done,
  @JsonValue("cancelled")
  cancelled,
  @JsonValue("too_many_retries")
  tooManyRetries;

  static WebsocketIrResponse fromValue(String value) {
    // TODO: This should be solvable in a much nicer manner using json_serialization.
    switch(value) {
      case "press_key":
        return pressKey;
      case "repeat_key":
        return repeatKey;
      case "short_code":
        return shortCode;
      case "done":
        return done;
      case "cancelled":
        return cancelled;
      case "too_many_retries":
        return tooManyRetries;
    }
    throw DecodingException(key: value);
  }
}
