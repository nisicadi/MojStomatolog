// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order()
  ..id = json['id'] as int?
  ..userId = json['userId'] as int?
  ..paymentId = json['paymentId'] as int?
  ..quantity = json['quantity'] as int?
  ..orderDate = json['orderDate'] == null
      ? null
      : DateTime.parse(json['orderDate'] as String)
  ..totalAmount = (json['totalAmount'] as num?)?.toDouble()
  ..status = json['status'] as int?
  ..orderItems = (json['orderItems'] as List<dynamic>?)
      ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
      .toList()
  ..payment = json['payment'] == null
      ? null
      : Payment.fromJson(json['payment'] as Map<String, dynamic>)
  ..user = json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'paymentId': instance.paymentId,
      'quantity': instance.quantity,
      'orderDate': instance.orderDate?.toIso8601String(),
      'totalAmount': instance.totalAmount,
      'status': instance.status,
      'orderItems': instance.orderItems,
      'payment': instance.payment,
      'user': instance.user,
    };
