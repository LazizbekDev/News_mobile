import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/logic/bloc/news_bloc.dart';
import 'package:news_app/widgets/news_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(FetchNews("latest"));
  }

  Future<void> _refreshNews() async {
    context.read<NewsBloc>().add(FetchNews("latest"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("The New York Times"),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNews,
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Text("Loading...");
            } else if (state is NewsLoaded) {
              return ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  return NewsCard(article: state.articles[index]);
                },
              );
            } else if (state is NewsError) {
              return Center(
                child: Text(state.message),
              );
            }
            return const Center(
              child: Text("Search for news"),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<NewsBloc>().add(
              FetchNews("jeffrey dahmer"),
            ),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
