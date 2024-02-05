import 'package:json_annotation/json_annotation.dart';
import 'package:mojstomatolog_desktop/models/product_category.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int? productId;
  String? name;
  String? description;
  int? productCategoryId;
  double? price;
  String? imageUrl;
  bool? active;

  ProductCategory? productCategory;

  Product();

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
