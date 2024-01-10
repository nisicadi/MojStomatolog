import 'package:json_annotation/json_annotation.dart';

part 'base_search.g.dart';

@JsonSerializable()
class BaseSearchObject {
  int? page;
  int? pageSize;

  BaseSearchObject();

  factory BaseSearchObject.fromJson(Map<String, dynamic> json) =>
      _$BaseSearchObjectFromJson(json);
  Map<String, dynamic> toJson() => _$BaseSearchObjectToJson(this);
}
