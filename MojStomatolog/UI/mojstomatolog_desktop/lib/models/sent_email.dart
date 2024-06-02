import 'package:json_annotation/json_annotation.dart';
import 'package:mojstomatolog_desktop/models/user.dart';

part 'sent_email.g.dart';

@JsonSerializable()
class SentEmail {
  int? id;
  String? subject;
  String? body;
  User? user;

  SentEmail();

  factory SentEmail.fromJson(Map<String, dynamic> json) =>
      _$SentEmailFromJson(json);
  Map<String, dynamic> toJson() => _$SentEmailToJson(this);
}
