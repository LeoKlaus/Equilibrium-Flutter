import 'package:flutter/material.dart';
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
  @JsonValue("other") other;


  static List<DropdownMenuEntry<CommandGroupType>> dropDownEntries = [
    DropdownMenuEntry(value: CommandGroupType.power, label: "Power"),
    DropdownMenuEntry(value: CommandGroupType.volume, label: "Volume"),
    DropdownMenuEntry(value: CommandGroupType.navigation, label: "Navigation"),
    DropdownMenuEntry(value: CommandGroupType.transport, label: "Transport"),
    DropdownMenuEntry(value: CommandGroupType.channel, label: "Channel"),
    DropdownMenuEntry(value: CommandGroupType.numeric, label: "Numbers"),
    DropdownMenuEntry(value: CommandGroupType.input, label: "Input"),
    DropdownMenuEntry(value: CommandGroupType.coloredButtons, label: "Colors"),
    DropdownMenuEntry(value: CommandGroupType.other, label: "Other")
  ];
}