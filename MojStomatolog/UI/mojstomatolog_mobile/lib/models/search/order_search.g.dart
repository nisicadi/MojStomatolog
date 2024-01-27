// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderSearchObject _$OrderSearchObjectFromJson(Map<String, dynamic> json) =>
    OrderSearchObject()
      ..page = json['page'] as int?
      ..pageSize = json['pageSize'] as int?
      ..userId = json['userId'] as int?;

Map<String, dynamic> _$OrderSearchObjectToJson(OrderSearchObject instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'userId': instance.userId,
    };
