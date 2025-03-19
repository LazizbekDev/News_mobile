import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/models/local_news_article.dart';
import 'package:news_app/logic/local_news_bloc/local_news_bloc.dart';
import 'package:news_app/widgets/local_news_carousel.dart';

class ManageNewsScreen extends StatefulWidget {
  const ManageNewsScreen({super.key});

  @override
  State<ManageNewsScreen> createState() => _ManageNewsScreenState();
}

class _ManageNewsScreenState extends State<ManageNewsScreen> {
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    debugPrint("ManageNewsScreen - dispatching LoadLocalNews");
    context.read<LocalNewsBloc>().add(LoadLocalNews());
  }

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
                  final article = LocalNewsArticle(
                    title: title,
                    url: url,
                    publishedAt: DateTime.now().toIso8601String(),
                  );
                  context.read<LocalNewsBloc>().add(AddNews(article));
                  _titleController.clear();
                  _urlController.clear();
                }
              },
              child: const Text("Add News"),
            ),
            const SizedBox(height: 20),
            const LocalNewsCarousel(),
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
