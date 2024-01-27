// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating()
  ..ratingId = json['ratingId'] as int?
  ..productId = json['productId'] as int?
  ..userId = json['userId'] as int?
  ..ratingValue = json['ratingValue'] as int?;

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'ratingId': instance.ratingId,
      'productId': instance.productId,
      'userId': instance.userId,
      'ratingValue': instance.ratingValue,
    };
