part of 'local_news_bloc.dart';

@immutable
abstract class LocalNewsState {}

class LocalNewsInitial extends LocalNewsState {}

class LocalNewsLoading extends LocalNewsState {}

class LocalNewsLoaded extends LocalNewsState {
  final List<LocalNewsArticle> articles;
  LocalNewsLoaded(this.articles);
}

class LocalNewsError extends LocalNewsState {
  final String message;
  LocalNewsError(this.message);
}