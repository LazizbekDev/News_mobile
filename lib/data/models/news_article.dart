import 'package:isar/isar.dart';

part 'news_article.g.dart';

@Collection()
class NewsArticle {
  Id id = Isar.autoIncrement;

  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;

  NewsArticle({
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
    this.id = Isar.autoIncrement,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      author: json['author'],
      title: json['title'] ?? "No title",
      description: json['description'],
      url: json['url'] ?? "",
      urlToImage: json['urlToImage'],
      publishedAt: DateTime.parse(json['publishedAt']),
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
    };
  }

  @override
  String toString() {
    return 'NewsArticle(id: $id, title: $title, url: $url, publishedAt: $publishedAt)';
  }
}
