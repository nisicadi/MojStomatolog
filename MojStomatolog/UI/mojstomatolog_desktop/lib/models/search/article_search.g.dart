// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleSearchObject _$ArticleSearchObjectFromJson(Map<String, dynamic> json) =>
    ArticleSearchObject()
      ..page = json['page'] as int?
      ..pageSize = json['pageSize'] as int?
      ..searchTerm = json['searchTerm'] as String?
      ..dateFrom = json['dateFrom'] == null
          ? null
          : DateTime.parse(json['dateFrom'] as String)
      ..dateTo = json['dateTo'] == null
          ? null
          : DateTime.parse(json['dateTo'] as String);

Map<String, dynamic> _$ArticleSearchObjectToJson(
        ArticleSearchObject instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'searchTerm': instance.searchTerm,
      'dateFrom': instance.dateFrom?.toIso8601String(),
      'dateTo': instance.dateTo?.toIso8601String(),
    };
