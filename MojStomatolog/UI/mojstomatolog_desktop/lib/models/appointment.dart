import 'package:json_annotation/json_annotation.dart';
import 'package:mojstomatolog_desktop/models/employee.dart';
import 'package:mojstomatolog_desktop/models/service.dart';
import 'package:mojstomatolog_desktop/models/user.dart';

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
  User? patient;
  Employee? employee;

  Appointment();

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
