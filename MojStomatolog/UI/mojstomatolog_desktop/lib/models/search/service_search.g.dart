// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceSearchObject _$ServiceSearchObjectFromJson(Map<String, dynamic> json) =>
    ServiceSearchObject()
      ..page = json['page'] as int?
      ..pageSize = json['pageSize'] as int?
      ..searchTerm = json['searchTerm'] as String?;

Map<String, dynamic> _$ServiceSearchObjectToJson(
        ServiceSearchObject instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'searchTerm': instance.searchTerm,
    };
