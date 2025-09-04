import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

enum CommandGroupType {
  @JsonValue("power")
  power,
  @JsonValue("volume")
  volume,
  @JsonValue("navigation")
  navigation,
  @JsonValue("transport")
  transport,
  @JsonValue("channel")
  channel,
  @JsonValue("numeric")
  numeric,
  @JsonValue("input")
  input,
  @JsonValue("colored_buttons")
  coloredButtons,
  @JsonValue("other")
  other;

  static List<DropdownMenuEntry<CommandGroupType>> dropDownEntries =
      CommandGroupType.values.map((type) {
        return DropdownMenuEntry(value: type, label: type.name());
      }).toList();

  String name() {
    switch (this) {
      case CommandGroupType.volume:
        return "Volume";
      case CommandGroupType.navigation:
        return "Navigation";
      case CommandGroupType.transport:
        return "Transport";
      case CommandGroupType.coloredButtons:
        return "Colors";
      case CommandGroupType.channel:
        return "Channel";
      case CommandGroupType.power:
        return "Power";
      case CommandGroupType.numeric:
        return "Numbers";
      case CommandGroupType.input:
        return "Input";
      case CommandGroupType.other:
        return "Other";
    }
  }
}
