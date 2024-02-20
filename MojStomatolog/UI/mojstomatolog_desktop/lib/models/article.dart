import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  int? articleId;
  String? title;
  String? summary;
  String? content;
  DateTime? publishDate;
  int? userCreatedId;

  Article();

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
