import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  int? employeeId;
  String? firstName;
  String? lastName;
  String? gender;
  String? email;
  String? number;
  String? specialization;
  DateTime? startDate;

  Employee();

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
