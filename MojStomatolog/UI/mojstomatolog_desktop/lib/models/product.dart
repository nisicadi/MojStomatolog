import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int? productId;
  String? name;
  String? description;
  String? category;
  double? price;
  String? number;
  String? imageUrl;
  bool? active;

  Product();

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
