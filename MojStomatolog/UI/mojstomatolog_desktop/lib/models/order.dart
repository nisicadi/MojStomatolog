import 'package:json_annotation/json_annotation.dart';
import 'package:mojstomatolog_desktop/models/order_item.dart';
import 'package:mojstomatolog_desktop/models/payment.dart';
import 'package:mojstomatolog_desktop/models/user.dart';

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
  User? user;

  Order();

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
