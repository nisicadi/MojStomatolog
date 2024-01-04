// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee()
  ..employeeId = json['employeeId'] as int?
  ..firstName = json['firstName'] as String?
  ..lastName = json['lastName'] as String?
  ..gender = json['gender'] as String?
  ..email = json['email'] as String?
  ..number = json['number'] as String?
  ..specialization = json['specialization'] as String?
  ..startDate = json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String);

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'employeeId': instance.employeeId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'email': instance.email,
      'number': instance.number,
      'specialization': instance.specialization,
      'startDate': instance.startDate?.toIso8601String(),
    };
