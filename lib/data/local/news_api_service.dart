import 'package:isar/isar.dart';
import 'package:news_app/data/models/local_news_article.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static final IsarService _instance = IsarService._internal();
  static Isar? _isar;

  factory IsarService() {
    return _instance;
  }

  IsarService._internal();

  Future<void> init() async {
    if (_isar != null) return;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [LocalNewsArticleSchema],
      directory: dir.path,
      inspector: true,
    );
  }

  Isar get isar {
    if (_isar == null) {
      throw Exception("Isar database is not initialized. Call init() first.");
    }
    return _isar!;
  }

  Future<void> saveArticle(LocalNewsArticle article) async {
    await isar.writeTxn(() async {
      await isar.localNewsArticles.put(article);
    });
  }

  Future<void> updateArticle(LocalNewsArticle updatedArticle) async {
    await isar.writeTxn(() async {
      await isar.localNewsArticles.put(updatedArticle);
    });
  }

  Future<void> deleteArticle(int id) async {
    await isar.writeTxn(() async {
      await isar.localNewsArticles.delete(id);
    });
  }

  Future<List<LocalNewsArticle>> fetchArticles() async {
    return await isar.localNewsArticles.where().findAll();
  }
}
