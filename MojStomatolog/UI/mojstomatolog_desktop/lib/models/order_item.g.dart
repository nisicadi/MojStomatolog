// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem()
  ..id = json['id'] as int?
  ..productId = json['productId'] as int?
  ..orderId = json['orderId'] as int?
  ..quantity = json['quantity'] as int?
  ..price = (json['price'] as num?)?.toDouble()
  ..product = json['product'] == null
      ? null
      : Product.fromJson(json['product'] as Map<String, dynamic>);

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'orderId': instance.orderId,
      'quantity': instance.quantity,
      'price': instance.price,
      'product': instance.product,
    };
