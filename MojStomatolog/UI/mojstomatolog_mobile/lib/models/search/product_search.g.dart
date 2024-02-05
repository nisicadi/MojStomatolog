// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSearchObject _$ProductSearchObjectFromJson(Map<String, dynamic> json) =>
    ProductSearchObject()
      ..page = json['page'] as int?
      ..pageSize = json['pageSize'] as int?
      ..searchTerm = json['searchTerm'] as String?
      ..priceFrom = (json['priceFrom'] as num?)?.toDouble()
      ..priceTo = (json['priceTo'] as num?)?.toDouble()
      ..isActive = json['isActive'] as bool?;

Map<String, dynamic> _$ProductSearchObjectToJson(
        ProductSearchObject instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'searchTerm': instance.searchTerm,
      'priceFrom': instance.priceFrom,
      'priceTo': instance.priceTo,
      'isActive': instance.isActive,
    };
