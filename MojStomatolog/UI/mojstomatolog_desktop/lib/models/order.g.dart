// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order()
  ..id = json['id'] as int?
  ..userId = json['userId'] as int?
  ..quantity = json['quantity'] as int?
  ..orderDate = json['orderDate'] == null
      ? null
      : DateTime.parse(json['orderDate'] as String)
  ..totalAmount = (json['totalAmount'] as num?)?.toDouble()
  ..orderItems = (json['orderItems'] as List<dynamic>?)
      ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'quantity': instance.quantity,
      'orderDate': instance.orderDate?.toIso8601String(),
      'totalAmount': instance.totalAmount,
      'orderItems': instance.orderItems,
    };
