import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mojstomatolog_mobile/models/search/article_search.dart';
import 'package:mojstomatolog_mobile/widgets/master_screen.dart';
import 'package:mojstomatolog_mobile/providers/article_provider.dart';
import 'package:mojstomatolog_mobile/models/article.dart';
import 'package:mojstomatolog_mobile/screens/article_screen.dart'; // Import ArticleScreen

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _isLoading = false;
  List<Article> _articles = [];

  @override
  void initState() {
    super.initState();
    _loadArticles();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadArticles({bool refresh = false}) async {
    if (_isLoading && !refresh) return;
    setState(() => _isLoading = true);

    if (refresh) {
      _currentPage = 1;
      _articles.clear();
    }

    try {
      var provider = ArticleProvider();
      var searchObject = ArticleSearchObject()
        ..page = _currentPage
        ..pageSize = _pageSize;

      var searchResult = await provider.get(filter: searchObject.toJson());
      setState(() {
        _articles.addAll(searchResult.results);
        if (!refresh) {
          _currentPage++;
        }
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadArticles();
    }
  }

  Future<void> _refreshList() async {
    await _loadArticles(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      currentIndex: 0,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _refreshList,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _articles.length,
            itemBuilder: (BuildContext context, int index) {
              Article article = _articles[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ArticleScreen(article: article),
                  ));
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(article.title ?? "Bez naslova",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text(article.summary ?? "Bez sažetka",
                            style: TextStyle(fontSize: 14)),
                        SizedBox(height: 8),
                        Text(
                            'Objavljeno: ${DateFormat('dd.MM.yyyy HH:mm').format(article.publishDate ?? DateTime.now())}',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: _isLoading ? CircularProgressIndicator() : null,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
