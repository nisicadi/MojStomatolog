// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment()
  ..id = json['id'] as int?
  ..paymentId = json['paymentId'] as int?
  ..amount = (json['amount'] as num?)?.toDouble()
  ..paymentDate = json['paymentDate'] == null
      ? null
      : DateTime.parse(json['paymentDate'] as String)
  ..paymentNumber = json['paymentNumber'] as String?
  ..payment = json['payment'] == null
      ? null
      : Payment.fromJson(json['payment'] as Map<String, dynamic>);

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'paymentId': instance.paymentId,
      'amount': instance.amount,
      'paymentDate': instance.paymentDate?.toIso8601String(),
      'paymentNumber': instance.paymentNumber,
      'payment': instance.payment,
    };
