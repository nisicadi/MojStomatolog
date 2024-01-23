import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable()
class Appointment {
  int? appointmentId;
  DateTime? appointmentDateTime;
  String? procedure;
  bool? isConfirmed;
  String? notes;
  int? patientId;

  Appointment();

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
