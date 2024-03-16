import 'package:json_annotation/json_annotation.dart';

part 'working_hours.g.dart';

@JsonSerializable()
class WorkingHours {
  int? id;
  int? dayOfWeek;
  String? startTime;
  String? endTime;
  String? breakStartTime;
  String? breakEndTime;
  int? userModifiedId;

  WorkingHours();

  factory WorkingHours.fromJson(Map<String, dynamic> json) =>
      _$WorkingHoursFromJson(json);
  Map<String, dynamic> toJson() => _$WorkingHoursToJson(this);
}
