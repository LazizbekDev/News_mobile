import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:news_app/logic/bloc/news_bloc.dart';
import 'package:news_app/data/models/news_article.dart';
import 'package:news_app/logic/bloc/news_bloc.dart';

class ManageNewsScreen extends StatefulWidget {
  const ManageNewsScreen({super.key});

  @override
  State<ManageNewsScreen> createState() => _ManageNewsScreenState();
}

class _ManageNewsScreenState extends State<ManageNewsScreen> {
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage News")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(labelText: "URL"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text.trim();
                final url = _urlController.text.trim();
                if (title.isNotEmpty && url.isNotEmpty) {
                  final article = NewsArticle(
                    title: title,
                    url: url,
                    publishedAt: DateTime.now(),
                  );
                  debugPrint(jsonEncode(article));
                  context.read<NewsBloc>().add(AddNews(article));
                  _titleController.clear();
                  _urlController.clear();
                }
              },
              child: const Text("Add News"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  if (state is NewsLoaded) {
                    return ListView.builder(
                      itemCount: state.articles.length,
                      itemBuilder: (context, index) {
                        final article = state.articles[index];
                        return ListTile(
                          title: Text(article.title),
                          subtitle: Text(article.url),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              context.read<NewsBloc>().add(
                                    DeleteNews(article.id),
                                  );
                            },
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    super.dispose();
  }
}
