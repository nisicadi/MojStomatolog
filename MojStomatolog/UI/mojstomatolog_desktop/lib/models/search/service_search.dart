import 'package:json_annotation/json_annotation.dart';
import 'package:mojstomatolog_desktop/models/search/base_search.dart';

part 'service_search.g.dart';

@JsonSerializable()
class ServiceSearchObject extends BaseSearchObject {
  String? searchTerm;

  ServiceSearchObject();

  factory ServiceSearchObject.fromJson(Map<String, dynamic> json) =>
      _$ServiceSearchObjectFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceSearchObjectToJson(this);
}
