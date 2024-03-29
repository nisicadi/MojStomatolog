// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment()
  ..id = json['id'] as int?
  ..amount = (json['amount'] as num?)?.toDouble()
  ..paymentDate = json['paymentDate'] == null
      ? null
      : DateTime.parse(json['paymentDate'] as String)
  ..paymentNumber = json['paymentNumber'] as String?;

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'paymentDate': instance.paymentDate?.toIso8601String(),
      'paymentNumber': instance.paymentNumber,
    };
