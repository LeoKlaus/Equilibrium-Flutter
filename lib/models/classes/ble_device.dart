import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'ble_device.g.dart';

@JsonSerializable()
class BleDevice {
  String name;
  String address;
  bool connected;
  bool paired;

  BleDevice({
    this.name = "",
    this.address = "",
    this.connected = false,
    this.paired = false,
  });

  factory BleDevice.fromJson(Map<String, dynamic> json) =>
      _$BleDeviceFromJson(json);

  Map<String, dynamic> toJson() => _$BleDeviceToJson(this);

  DropdownMenuEntry<BleDevice?> toDropDownMenuEntry() {
    return DropdownMenuEntry(value: this, label: name);
  }
}
