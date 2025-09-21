import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

enum IntegrationAction {
  @JsonValue("toggle_light") toggleLight,
  @JsonValue("brightness_up") brightnessUp,
  @JsonValue("brightness_down") brightnessDown;

  static List<DropdownMenuEntry<IntegrationAction>> dropDownEntries = [
    DropdownMenuEntry(value: IntegrationAction.toggleLight, label: "Toggle light"),
    DropdownMenuEntry(value: IntegrationAction.brightnessUp, label: "Brightness up"),
    DropdownMenuEntry(value: IntegrationAction.brightnessDown, label: "Brightness down"),
  ];
}