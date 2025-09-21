import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

enum CommandType {
  @JsonValue("ir") infrared,
  @JsonValue("bluetooth") bluetooth,
  @JsonValue("network") network,
  @JsonValue("script") script,
  @JsonValue("integration") integration;


  static List<DropdownMenuEntry<CommandType>> dropDownEntries = [
    DropdownMenuEntry(value: CommandType.infrared, label: "Infrared"),
    DropdownMenuEntry(value: CommandType.bluetooth, label: "Bluetooth"),
    DropdownMenuEntry(value: CommandType.network, label: "Network"),
    // TODO: Enable when script commands are available
    //DropdownMenuEntry(value: CommandType.script, label: "Script"),
    DropdownMenuEntry(value: CommandType.integration, label: "Integration")
  ];
}