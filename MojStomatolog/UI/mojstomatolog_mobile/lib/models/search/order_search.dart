import 'package:json_annotation/json_annotation.dart';
import 'package:mojstomatolog_mobile/models/search/base_search.dart';

part 'order_search.g.dart';

@JsonSerializable()
class OrderSearchObject extends BaseSearchObject {
  int? userId;

  OrderSearchObject();

  factory OrderSearchObject.fromJson(Map<String, dynamic> json) =>
      _$OrderSearchObjectFromJson(json);
  Map<String, dynamic> toJson() => _$OrderSearchObjectToJson(this);
}
