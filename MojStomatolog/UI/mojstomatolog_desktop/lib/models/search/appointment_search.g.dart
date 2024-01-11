// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentSearchObject _$AppointmentSearchObjectFromJson(
        Map<String, dynamic> json) =>
    AppointmentSearchObject()
      ..page = json['page'] as int?
      ..pageSize = json['pageSize'] as int?
      ..searchTerm = json['searchTerm'] as String?;

Map<String, dynamic> _$AppointmentSearchObjectToJson(
        AppointmentSearchObject instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'searchTerm': instance.searchTerm,
    };
