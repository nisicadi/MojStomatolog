// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategorySearchObject _$ProductCategorySearchObjectFromJson(
        Map<String, dynamic> json) =>
    ProductCategorySearchObject()
      ..page = json['page'] as int?
      ..pageSize = json['pageSize'] as int?
      ..searchTerm = json['searchTerm'] as String?;

Map<String, dynamic> _$ProductCategorySearchObjectToJson(
        ProductCategorySearchObject instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'searchTerm': instance.searchTerm,
    };
