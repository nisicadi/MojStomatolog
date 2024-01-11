import 'package:json_annotation/json_annotation.dart';
import 'package:mojstomatolog_desktop/models/search/base_search.dart';

part 'appointment_search.g.dart';

@JsonSerializable()
class AppointmentSearchObject extends BaseSearchObject {
  String? searchTerm;
  DateTime? dateTimeFrom;
  DateTime? dateTimeTo;
  bool? isConfirmed;

  AppointmentSearchObject();

  factory AppointmentSearchObject.fromJson(Map<String, dynamic> json) =>
      _$AppointmentSearchObjectFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentSearchObjectToJson(this);
}
