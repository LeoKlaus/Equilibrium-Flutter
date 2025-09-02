// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserImage _$UserImageFromJson(Map<String, dynamic> json) => UserImage(
  id: (json['id'] as num?)?.toInt(),
  filename: json['filename'] as String? ?? "",
  path: json['path'] as String? ?? "",
);

Map<String, dynamic> _$UserImageToJson(UserImage instance) => <String, dynamic>{
  'id': instance.id,
  'filename': instance.filename,
  'path': instance.path,
};
