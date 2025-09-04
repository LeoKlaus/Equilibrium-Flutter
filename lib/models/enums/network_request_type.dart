import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

enum NetworkRequestType {
  @JsonValue("get")
  get,
  @JsonValue("post")
  post,
  @JsonValue("patch")
  patch,
  @JsonValue("delete")
  delete,
  @JsonValue("head")
  head,
  @JsonValue("put")
  put;

  static List<DropdownMenuEntry<NetworkRequestType>> dropDownEntries = NetworkRequestType.values.map((value) {
    return DropdownMenuEntry(value: value, label: value.upperName());
  }).toList();

  String upperName() {
    return name.toUpperCase();
  }

  bool canHaveBody() {
    return this == NetworkRequestType.post ||
        this == NetworkRequestType.patch ||
        this == NetworkRequestType.put;
  }
}
