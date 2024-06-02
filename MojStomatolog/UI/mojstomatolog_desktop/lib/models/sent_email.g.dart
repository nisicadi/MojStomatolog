// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sent_email.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SentEmail _$SentEmailFromJson(Map<String, dynamic> json) => SentEmail()
  ..id = json['id'] as int?
  ..subject = json['subject'] as String?
  ..body = json['body'] as String?
  ..user = json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$SentEmailToJson(SentEmail instance) => <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'body': instance.body,
      'user': instance.user,
    };
