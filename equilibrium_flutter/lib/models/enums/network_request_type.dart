import 'package:json_annotation/json_annotation.dart';

enum NetworkRequestType {
  @JsonValue("get") get,
  @JsonValue("post") post,
  @JsonValue("delete") delete,
  @JsonValue("head") head,
  @JsonValue("patch") patch,
  @JsonValue("put") put
}

