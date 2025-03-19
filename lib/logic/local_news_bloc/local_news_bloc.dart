import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/local/news_api_service.dart';
import 'package:news_app/data/models/local_news_article.dart';

part 'local_news_event.dart';
part 'local_news_state.dart';

class LocalNewsBloc extends Bloc<LocalNewsEvent, LocalNewsState> {
  IsarService isarService;
  LocalNewsBloc({required this.isarService}) : super(LocalNewsInitial()) {
    on<LoadLocalNews>((event, emit) async {
      emit(LocalNewsLoading());

      try {
        final articles = await isarService.fetchArticles();
        emit(LocalNewsLoaded(articles));
      } catch (e) {
        emit(LocalNewsError("Error from local_news_block.dart line 19: $e"));
        debugPrint("Error from local_news_block.dart line 19: $e");
      }
    });

    on<AddNews>((AddNews event, emit) async {
      try {
        await isarService.saveArticle(event.article);
        final articles = await isarService.fetchArticles();
        emit(LocalNewsLoaded(articles));
      } catch (e) {
        emit(LocalNewsError("Error from local_news_block.dart line 29: $e"));
      }
    });

    on<UpdateNews>((UpdateNews event, emit) async {
      try {
        await isarService.updateArticle(event.updatedArticle);
        final articles = await isarService.fetchArticles();
        emit(LocalNewsLoaded(articles));
      } catch (e) {
        emit(LocalNewsError("Error: $e"));
      }
    });

    on<DeleteNews>((DeleteNews event, emit) async {
      try {
        await isarService.deleteArticle(event.id);
        final articles = await isarService.fetchArticles();

        emit(LocalNewsLoaded(articles));
      } catch (e) {
        emit(LocalNewsError("Error from local_news_block.dart line 40: $e"));
      }
    });
  }
}
