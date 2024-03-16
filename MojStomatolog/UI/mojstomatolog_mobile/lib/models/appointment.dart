import 'package:json_annotation/json_annotation.dart';
import 'package:mojstomatolog_mobile/models/employee.dart';
import 'package:mojstomatolog_mobile/models/service.dart';

part 'appointment.g.dart';

@JsonSerializable()
class Appointment {
  int? appointmentId;
  DateTime? appointmentDateTime;
  int? serviceId;
  bool? isConfirmed;
  String? notes;
  int? patientId;
  int? employeeId;

  Service? service;
  Employee? employee;

  Appointment();

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
