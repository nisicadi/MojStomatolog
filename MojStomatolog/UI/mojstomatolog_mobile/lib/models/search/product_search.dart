import 'package:json_annotation/json_annotation.dart';
import 'package:mojstomatolog_mobile/models/search/base_search.dart';

part 'product_search.g.dart';

@JsonSerializable()
class ProductSearchObject extends BaseSearchObject {
  String? searchTerm;
  double? priceFrom;
  double? priceTo;
  bool? isActive;

  ProductSearchObject();

  factory ProductSearchObject.fromJson(Map<String, dynamic> json) =>
      _$ProductSearchObjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProductSearchObjectToJson(this);
}
