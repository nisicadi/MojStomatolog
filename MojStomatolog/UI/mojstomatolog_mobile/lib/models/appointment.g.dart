// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment()
  ..appointmentId = json['appointmentId'] as int?
  ..appointmentDateTime = json['appointmentDateTime'] == null
      ? null
      : DateTime.parse(json['appointmentDateTime'] as String)
  ..procedure = json['procedure'] as String?
  ..isConfirmed = json['isConfirmed'] as bool?
  ..notes = json['notes'] as String?
  ..patientId = json['patientId'] as int?;

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'appointmentDateTime': instance.appointmentDateTime?.toIso8601String(),
      'procedure': instance.procedure,
      'isConfirmed': instance.isConfirmed,
      'notes': instance.notes,
      'patientId': instance.patientId,
    };
