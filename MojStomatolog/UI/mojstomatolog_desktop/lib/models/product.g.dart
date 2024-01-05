// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product()
  ..productId = json['productId'] as int?
  ..name = json['name'] as String?
  ..description = json['description'] as String?
  ..category = json['category'] as String?
  ..price = (json['price'] as num?)?.toDouble()
  ..number = json['number'] as String?
  ..imageUrl = json['imageUrl'] as String?
  ..active = json['active'] as bool?;

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'pruductId': instance.productId,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'price': instance.price,
      'number': instance.number,
      'imageUrl': instance.imageUrl,
      'active': instance.active,
    };
