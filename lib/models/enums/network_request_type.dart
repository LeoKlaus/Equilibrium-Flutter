import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

enum NetworkRequestType {
  @JsonValue("get")
  get,
  @JsonValue("post")
  post,
  @JsonValue("delete")
  delete,
  @JsonValue("head")
  head,
  @JsonValue("patch")
  patch,
  @JsonValue("put")
  put;

  static List<DropdownMenuEntry<NetworkRequestType>> dropDownEntries = [
    DropdownMenuEntry(value: NetworkRequestType.get, label: "GET"),
    DropdownMenuEntry(value: NetworkRequestType.post, label: "POST"),
    DropdownMenuEntry(value: NetworkRequestType.patch, label: "PATCH"),
    DropdownMenuEntry(value: NetworkRequestType.delete, label: "DELETE"),
    DropdownMenuEntry(value: NetworkRequestType.head, label: "HEAD"),
    DropdownMenuEntry(value: NetworkRequestType.put, label: "PUT"),
  ];

  bool canHaveBody() {
    return this == NetworkRequestType.post ||
        this == NetworkRequestType.patch ||
        this == NetworkRequestType.put;
  }
}
