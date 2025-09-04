import 'package:flutter/material.dart';

enum BluetoothCommandType {
  regularKey,
  mediaKey;

  static List<DropdownMenuEntry<BluetoothCommandType>> dropDownEntries = [
    DropdownMenuEntry(value: BluetoothCommandType.regularKey, label: "Regular key"),
    DropdownMenuEntry(value: BluetoothCommandType.mediaKey, label: "Media key"),
  ];
}