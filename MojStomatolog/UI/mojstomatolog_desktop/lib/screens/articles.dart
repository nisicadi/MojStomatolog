import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mojstomatolog_desktop/modals/add-article.dart';
import 'package:mojstomatolog_desktop/models/article.dart';
import 'package:mojstomatolog_desktop/models/search/base_search.dart';
import 'package:mojstomatolog_desktop/providers/article_provider.dart';
import 'package:mojstomatolog_desktop/widgets/paginated_list_screen.dart';

class ArticleListScreen extends StatefulWidget {
  @override
  _ArticleListScreenState createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  final ArticleProvider _articleProvider = ArticleProvider();
  List<Article> _articles = [];
  int _currentPage = 1;
  int _totalCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  Future<void> _fetchArticles({int page = 1}) async {
    try {
      var searchObject = BaseSearchObject();
      searchObject.page = page;
      searchObject.pageSize = 10;
      final result = await _articleProvider.get(filter: searchObject.toJson());

      setState(() {
        _articles = result.results as List<Article>;
        _currentPage = page;
        _totalCount = result.count;
      });
    } catch (e) {
      print("Greška pri dohvaćanju članaka: $e");
    }
  }

  void _addOrUpdateArticle(Article article, {bool isUpdate = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddArticleModal(
          onArticleAdded: (newArticle) {
            _fetchArticles(page: _currentPage);
          },
          initialArticle: isUpdate ? article : null,
        );
      },
    );
  }

  Widget _buildIconButton(IconData icon, String tooltip, Function onPressed) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon),
        onPressed: () => onPressed(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> columns = [
      DataColumn(label: Text('Id')),
      DataColumn(label: Text('Naslov')),
      DataColumn(label: Text('Sažetak')),
      DataColumn(label: Text('Datum Objavljivanja')),
      DataColumn(label: Text('Uredi')),
      DataColumn(label: Text('Obriši')),
    ];

    final List<DataRow> rows = _articles.map((article) {
      return DataRow(
        cells: [
          DataCell(Text(article.articleId.toString())),
          DataCell(Text(article.title ?? '')),
          DataCell(Text(article.summary ?? '')),
          DataCell(Text(DateFormat('dd.MM.yyyy').format(article.publishDate ?? DateTime.now()))),
          DataCell(_buildIconButton(Icons.edit, 'Uredi', () {
            _addOrUpdateArticle(article, isUpdate: true);
          })),
          DataCell(_buildIconButton(Icons.delete, 'Obriši', () {
            _showDeleteConfirmationDialog(context, article.articleId!);
          })),
        ],
      );
    }).toList();

    return PageableListScreen(
      currentPage: 'Članci',
      columns: columns,
      rows: rows,
      addButtonCallback: () => _addOrUpdateArticle(Article()),
      totalCount: _totalCount,
      onPageChanged: (int newPage) => _fetchArticles(page: newPage),
      currentPageIndex: _currentPage,
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int articleId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Potvrda Brisanja'),
          content: Text('Jeste li sigurni da želite obrisati ovaj članak?'),
          actions: [
            TextButton(
              onPressed: () async {
                await _articleProvider.delete(articleId);
                _fetchArticles(page: _currentPage);
                Navigator.of(context).pop();
              },
              child: Text('Da'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ne'),
            ),
          ],
        );
      },
    );
  }
}