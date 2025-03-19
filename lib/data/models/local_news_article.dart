import 'package:isar/isar.dart';
import 'package:news_app/data/models/news_article.dart';
part 'local_news_article.g.dart';

@Collection()
class LocalNewsArticle {
  Id id = Isar.autoIncrement;

  late String title;
  late String? description;
  late String url;
  late String? imageUrl;
  late String publishedAt;

  LocalNewsArticle({
    required this.title,
    required this.url,
    required this.publishedAt,
    this.description,
    this.imageUrl,
  });

  factory LocalNewsArticle.fromNewsArticle(NewsArticle article) {
    return LocalNewsArticle(
      title: article.title,
      description: article.description ?? "",
      url: article.url,
      imageUrl: article.urlToImage,
      publishedAt: article.publishedAt.toIso8601String(),
    );
  }

  LocalNewsArticle copyWith({
    int? id,
    String? title,
    String? description,
    String? url,
    String? imageUrl,
    String? publishedAt,
  }) {
    return LocalNewsArticle(
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      imageUrl: imageUrl ?? this.imageUrl,
      publishedAt: publishedAt ?? this.publishedAt,
    )..id = id ?? this.id;
  }
}
