import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/repository/news_repository.dart';
import 'package:news_app/logic/bloc/news_bloc.dart';
import 'package:news_app/screens/news_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(
        NewsRepository(),
      ),
      child: const MaterialApp(
        home: NewsScreen(),
      ),
    );
  }
}
