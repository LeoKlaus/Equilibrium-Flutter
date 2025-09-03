import 'package:json_annotation/json_annotation.dart';

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
}
