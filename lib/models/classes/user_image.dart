import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'user_image.g.dart';

@JsonSerializable()
class UserImage {
  int? id;
  String filename;
  String path;

  UserImage({this.id, this.filename = "", this.path = ""});

  factory UserImage.fromJson(Map<String, dynamic> json) =>
      _$UserImageFromJson(json);

  Map<String, dynamic> toJson() => _$UserImageToJson(this);

  DropdownMenuEntry<UserImage?> toDropDownMenuEntry(String? baseUri) {
    return DropdownMenuEntry(
      value: this,
      label: filename,
      leadingIcon: Image.network("http://$baseUri/images/$id", width: 32, height: 32),
    );
  }
}
