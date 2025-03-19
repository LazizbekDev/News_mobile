part of 'local_news_bloc.dart';

@immutable
abstract class LocalNewsEvent {}

class AddNews extends LocalNewsEvent {
  final LocalNewsArticle article;
  AddNews(this.article);
}

class DeleteNews extends LocalNewsEvent {
  final int id;
  DeleteNews(this.id);
}

class LoadLocalNews extends LocalNewsEvent {}
