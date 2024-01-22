import 'package:flutter/material.dart';
import 'package:mojstomatolog_mobile/models/article.dart';

class ArticleScreen extends StatelessWidget {
  final Article article;

  ArticleScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title ?? "Bez naslova"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (article.title != null)
                Text(article.title!,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              if (article.content != null)
                Text(article.content!, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
