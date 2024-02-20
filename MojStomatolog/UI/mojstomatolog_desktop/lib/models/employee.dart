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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Employee &&
        other.employeeId == employeeId &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.gender == gender &&
        other.email == email &&
        other.number == number &&
        other.specialization == specialization &&
        other.startDate == startDate;
  }

  @override
  int get hashCode {
    return employeeId.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        gender.hashCode ^
        email.hashCode ^
        number.hashCode ^
        specialization.hashCode ^
        startDate.hashCode;
  }
}
