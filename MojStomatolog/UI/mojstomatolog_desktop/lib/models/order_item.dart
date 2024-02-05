import 'package:json_annotation/json_annotation.dart';
import 'package:mojstomatolog_desktop/models/product.dart';

part 'order_item.g.dart';

@JsonSerializable()
class OrderItem {
  int? id;
  int? productId;
  int? orderId;
  int? quantity;
  double? price;
  Product? product;

  OrderItem();

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
