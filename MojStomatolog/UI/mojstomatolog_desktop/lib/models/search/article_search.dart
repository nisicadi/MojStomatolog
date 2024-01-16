import 'package:json_annotation/json_annotation.dart';
import 'package:mojstomatolog_desktop/models/search/base_search.dart';

part 'article_search.g.dart';

@JsonSerializable()
class ArticleSearchObject extends BaseSearchObject {
  String? searchTerm;
  DateTime? dateFrom;
  DateTime? dateTo;

  ArticleSearchObject();

  factory ArticleSearchObject.fromJson(Map<String, dynamic> json) =>
      _$ArticleSearchObjectFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleSearchObjectToJson(this);
}
