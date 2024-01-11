// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeSearchObject _$EmployeeSearchObjectFromJson(
        Map<String, dynamic> json) =>
    EmployeeSearchObject()
      ..page = json['page'] as int?
      ..pageSize = json['pageSize'] as int?
      ..searchTerm = json['searchTerm'] as String?;

Map<String, dynamic> _$EmployeeSearchObjectToJson(
        EmployeeSearchObject instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'searchTerm': instance.searchTerm,
    };
