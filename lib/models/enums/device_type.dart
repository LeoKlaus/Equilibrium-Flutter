import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

enum DeviceType {
  @JsonValue("display") display,
  @JsonValue("amplifier") amplifier,
  @JsonValue("player") player,
  @JsonValue("integration") integration,
  @JsonValue("other") other;


  IconData get icon {
    switch (this) {
      case DeviceType.display:
        return Icons.tv;
      case DeviceType.amplifier:
        return Icons.speaker;
      case DeviceType.player:
        return Icons.settings_input_hdmi;
      case DeviceType.integration:
        return Icons.extension;
      case DeviceType.other:
        return Icons.device_unknown;
    }
  }

  static List<DropdownMenuEntry<DeviceType>> dropDownEntries =
  DeviceType.values.map((type) {
    return DropdownMenuEntry(value: type, label: type.name());
  }).toList();

  String name() {
    switch (this) {
      case DeviceType.display:
        return "Display";
      case DeviceType.amplifier:
        return "Amplifier";
      case DeviceType.player:
        return "Player";
      case DeviceType.integration:
        return "Integration";
      case DeviceType.other:
        return "Other";
    }
  }
}