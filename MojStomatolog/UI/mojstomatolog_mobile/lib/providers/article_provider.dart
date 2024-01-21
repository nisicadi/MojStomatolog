import 'package:mojstomatolog_mobile/models/article.dart';
import 'base_provider.dart';

class ArticleProvider extends BaseProvider<Article> {
  ArticleProvider() : super("Article");

  @override
  Article fromJson(data) {
    return Article.fromJson(data);
  }
}
