import 'package:json_annotation/json_annotation.dart';
import 'package:mojstomatolog_mobile/models/search/base_search.dart';

part 'employee_search.g.dart';

@JsonSerializable()
class EmployeeSearchObject extends BaseSearchObject {
  String? searchTerm;
  DateTime? dateFrom;
  DateTime? dateTo;

  EmployeeSearchObject();

  factory EmployeeSearchObject.fromJson(Map<String, dynamic> json) =>
      _$EmployeeSearchObjectFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeSearchObjectToJson(this);
}
