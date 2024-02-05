// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product()
  ..productId = json['productId'] as int?
  ..name = json['name'] as String?
  ..description = json['description'] as String?
  ..productCategoryId = json['productCategoryId'] as int?
  ..price = (json['price'] as num?)?.toDouble()
  ..imageUrl = json['imageUrl'] as String?
  ..active = json['active'] as bool?
  ..productCategory = json['productCategory'] == null
      ? null
      : ProductCategory.fromJson(
          json['productCategory'] as Map<String, dynamic>);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productId': instance.productId,
      'name': instance.name,
      'description': instance.description,
      'productCategoryId': instance.productCategoryId,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'active': instance.active,
      'productCategory': instance.productCategory,
    };
