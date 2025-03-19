part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class FetchNews extends NewsEvent {
  final String query;
  FetchNews(this.query);
}

class AddNews extends NewsEvent {
  final NewsArticle article;
  AddNews(this.article);
}

class DeleteNews extends NewsEvent {
  final int id;
  DeleteNews(this.id);
}

class LoadLocalNews extends NewsEvent {}
