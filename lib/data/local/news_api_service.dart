import 'package:isar/isar.dart';
import 'package:news_app/data/models/news_article.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = _initDb();
  }

  Future<Isar> _initDb() async {
    final dir = await getApplicationDocumentsDirectory();

    return await Isar.open(
      [NewsArticleSchema],
      directory: dir.path,
      inspector: true,
    );
  }

  Future<void> saveArticle(NewsArticle article) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.newsArticles.put(article);
    });
  }

  Future<void> deleteArticle(Id id) async {
    final isar = await db;

    await isar.writeTxn(() async {
      await isar.newsArticles.delete(id);
    });
  }

  Future<List<NewsArticle>> fetchArticles() async {
    final isar = await db;
    return await isar.newsArticles.where().findAll();
  }
}
