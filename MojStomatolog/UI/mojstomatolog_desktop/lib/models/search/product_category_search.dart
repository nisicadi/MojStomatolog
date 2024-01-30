import 'package:json_annotation/json_annotation.dart';
import 'package:mojstomatolog_desktop/models/search/base_search.dart';

part 'product_category_search.g.dart';

@JsonSerializable()
class ProductCategorySearchObject extends BaseSearchObject {
  String? searchTerm;

  ProductCategorySearchObject();

  factory ProductCategorySearchObject.fromJson(Map<String, dynamic> json) =>
      _$ProductCategorySearchObjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProductCategorySearchObjectToJson(this);
}
