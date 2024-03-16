// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'working_hours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkingHours _$WorkingHoursFromJson(Map<String, dynamic> json) => WorkingHours()
  ..id = json['id'] as int?
  ..dayOfWeek = json['dayOfWeek'] as int?
  ..startTime = json['startTime'] as String?
  ..endTime = json['endTime'] as String?
  ..breakStartTime = json['breakStartTime'] as String?
  ..breakEndTime = json['breakEndTime'] as String?
  ..userModifiedId = json['userModifiedId'] as int?;

Map<String, dynamic> _$WorkingHoursToJson(WorkingHours instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dayOfWeek': instance.dayOfWeek,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'breakStartTime': instance.breakStartTime,
      'breakEndTime': instance.breakEndTime,
      'userModifiedId': instance.userModifiedId,
    };
