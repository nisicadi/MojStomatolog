import 'package:json_annotation/json_annotation.dart';
import 'package:mojstomatolog_desktop/models/user.dart';

part 'appointment.g.dart';

@JsonSerializable()
class Appointment {
  int? appointmentId;
  DateTime? appointmentDateTime;
  String? procedure;
  bool? isConfirmed;
  String? notes;
  int? patientId;
  User? patient;

  Appointment();

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
