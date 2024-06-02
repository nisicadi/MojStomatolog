import 'package:json_annotation/json_annotation.dart';
import 'package:mojstomatolog_mobile/models/order_item.dart';
import 'package:mojstomatolog_mobile/models/payment.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  int? id;
  int? userId;
  int? paymentId;
  int? quantity;
  DateTime? orderDate;
  double? totalAmount;
  int? status;
  List<OrderItem>? orderItems;
  Payment? payment;

  Order();

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
