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
      ..searchTerm = json['searchTerm'] as String?
      ..dateTimeFrom = json['dateTimeFrom'] == null
          ? null
          : DateTime.parse(json['dateTimeFrom'] as String)
      ..dateTimeTo = json['dateTimeTo'] == null
          ? null
          : DateTime.parse(json['dateTimeTo'] as String)
      ..isConfirmed = json['isConfirmed'] as bool?;

Map<String, dynamic> _$AppointmentSearchObjectToJson(
        AppointmentSearchObject instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'searchTerm': instance.searchTerm,
      'dateTimeFrom': instance.dateTimeFrom?.toIso8601String(),
      'dateTimeTo': instance.dateTimeTo?.toIso8601String(),
      'isConfirmed': instance.isConfirmed,
    };
