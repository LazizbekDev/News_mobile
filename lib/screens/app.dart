import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/local/news_api_service.dart';
import 'package:news_app/data/repository/news_repository.dart';
import 'package:news_app/logic/local_news_bloc/local_news_bloc.dart';
import 'package:news_app/logic/news_block/news_bloc.dart';
import 'package:news_app/screens/news_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(
            isarService: IsarService(),
            newsRepository: NewsRepository(),
          ),
        ),
        BlocProvider<LocalNewsBloc>(
          create: (context) => LocalNewsBloc(
            isarService: IsarService(),
          ),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NewsScreen(),
      ),
    );
  }
}
