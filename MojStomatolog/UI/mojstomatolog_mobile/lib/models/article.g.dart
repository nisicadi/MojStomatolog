// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article()
  ..articleId = json['articleId'] as int?
  ..title = json['title'] as String?
  ..summary = json['summary'] as String?
  ..content = json['content'] as String?
  ..publishDate = json['publishDate'] == null
      ? null
      : DateTime.parse(json['publishDate'] as String);

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'articleId': instance.articleId,
      'title': instance.title,
      'summary': instance.summary,
      'content': instance.content,
      'publishDate': instance.publishDate?.toIso8601String(),
    };
