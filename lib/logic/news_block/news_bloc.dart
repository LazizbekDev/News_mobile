import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/data/local/news_api_service.dart';
import 'package:news_app/data/models/news_article.dart';
import 'package:news_app/data/repository/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;
  final IsarService isarService;
  NewsBloc({required this.isarService, required this.newsRepository})
      : super(NewsInitial()) {
    on<FetchNews>((event, emit) async {
      emit(NewsLoading());

      try {
        final newResponse = await newsRepository.fetchNews(event.query);
        emit(NewsLoaded(newResponse.articles));
      } catch (e) {
        emit(NewsError("Failed to fetch news: $e"));
      }
    });
  }
}
