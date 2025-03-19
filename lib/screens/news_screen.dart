import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/logic/local_news_bloc/local_news_bloc.dart';
import 'package:news_app/logic/news_block/news_bloc.dart';
import 'package:news_app/widgets/local_news_carousel.dart';
import 'package:news_app/widgets/news_item.dart';
import 'package:news_app/widgets/sidebar.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<LocalNewsBloc>().add(LoadLocalNews());
    context.read<NewsBloc>().add(FetchNews("latest"));
  }

  void _fetchNews(String query) {
    context.read<NewsBloc>().add(FetchNews(query));
  }

  Future<void> _refreshNews() async {
    _searchController.text = "";
    context.read<NewsBloc>().add(FetchNews("latest"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search news...",
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => _fetchNews(_searchController.text.isEmpty
                  ? "latest"
                  : _searchController.text),
            ),
          ),
          onSubmitted: (query) => _fetchNews(query),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNews,
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NewsLoaded) {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const LocalNewsCarousel(),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.articles.length,
                      itemBuilder: (context, index) {
                        return NewsItem(article: state.articles[index]);
                      },
                    ),
                  ),
                ],
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
        onPressed: _refreshNews,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
