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
  ..serviceId = json['serviceId'] as int?
  ..isConfirmed = json['isConfirmed'] as bool?
  ..notes = json['notes'] as String?
  ..patientId = json['patientId'] as int?
  ..employeeId = json['employeeId'] as int?
  ..service = json['service'] == null
      ? null
      : Service.fromJson(json['service'] as Map<String, dynamic>)
  ..employee = json['employee'] == null
      ? null
      : Employee.fromJson(json['employee'] as Map<String, dynamic>);

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'appointmentDateTime': instance.appointmentDateTime?.toIso8601String(),
      'serviceId': instance.serviceId,
      'isConfirmed': instance.isConfirmed,
      'notes': instance.notes,
      'patientId': instance.patientId,
      'employeeId': instance.employeeId,
      'service': instance.service,
      'employee': instance.employee,
    };
