import 'package:json_annotation/json_annotation.dart';
import 'package:mojstomatolog_desktop/models/order_item.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  int? id;
  int? userId;
  int? quantity;
  DateTime? orderDate;
  double? totalAmount;
  List<OrderItem>? orderItems;

  Order();

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
