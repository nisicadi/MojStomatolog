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
      ..searchTerm = json['searchTerm'] as String?
      ..dateFrom = json['dateFrom'] == null
          ? null
          : DateTime.parse(json['dateFrom'] as String)
      ..dateTo = json['dateTo'] == null
          ? null
          : DateTime.parse(json['dateTo'] as String);

Map<String, dynamic> _$EmployeeSearchObjectToJson(
        EmployeeSearchObject instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'searchTerm': instance.searchTerm,
      'dateFrom': instance.dateFrom?.toIso8601String(),
      'dateTo': instance.dateTo?.toIso8601String(),
    };
