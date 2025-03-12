import 'package:flutter/material.dart';
import 'package:news_app/data/models/news_article.dart';
import 'package:news_app/widgets/news_item.dart';

class NewsCard extends StatelessWidget {
  final NewsArticle article;
  const NewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: NewsItem(
        title: article.title,
        description: article.description ?? "No Description Available",
        imageUrl: article.urlToImage ?? "",
      ),
    );
  }
}
