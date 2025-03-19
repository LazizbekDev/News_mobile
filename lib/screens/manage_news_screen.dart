import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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
  final _descriptionController = TextEditingController();
  File? _imageFile;
  LocalNewsArticle? _editingArticle;

  @override
  void initState() {
    super.initState();
    debugPrint("ManageNewsScreen - dispatching LoadLocalNews");
    context.read<LocalNewsBloc>().add(LoadLocalNews());
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final File tempImage = File(pickedFile.path);
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String fileName = pickedFile.path.split('/').last;
    final File savedImage = await tempImage.copy('${appDir.path}/$fileName');

    setState(() {
      _imageFile = savedImage;
    });
  }

  void _addNews() {
    final title = _titleController.text.trim();
    final url = _urlController.text.trim();
    final description = _descriptionController.text.trim();
    final imageUrl = _imageFile?.path ?? "";

    if (title.isNotEmpty &&
        url.isNotEmpty &&
        description.isNotEmpty &&
        imageUrl.isNotEmpty) {
      if (_editingArticle != null) {
        final updatedArticle = _editingArticle!.copyWith(
          title: title,
          url: url,
          description: description,
          imageUrl: imageUrl,
          publishedAt: DateTime.now().toIso8601String(),
        );

        context.read<LocalNewsBloc>().add(UpdateNews(updatedArticle));
        debugPrint("updated");
      } else {
        final newArticle = LocalNewsArticle(
          title: title,
          url: url,
          description: description,
          imageUrl: imageUrl,
          publishedAt: DateTime.now().toIso8601String(),
        );

        context.read<LocalNewsBloc>().add(AddNews(newArticle));
      }

      _clearForm();
    }
  }

  void _editNews(LocalNewsArticle article) {
    _titleController.text = article.title;
    _urlController.text = article.url;
    _descriptionController.text = article.description ?? "";

    setState(() {
      _imageFile = article.imageUrl != null ? File(article.imageUrl!) : null;
      _editingArticle = article;
    });
  }

  void _clearForm() {
    _titleController.clear();
    _urlController.clear();
    _descriptionController.clear();

    setState(() {
      _imageFile = null;
      _editingArticle = null;
    });
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
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            _imageFile != null
                ? Image.file(
                    _imageFile!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : const SizedBox(),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text("Pick Image"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addNews,
              child: const Text("Add News"),
            ),
            const SizedBox(height: 20),
            BlocBuilder<LocalNewsBloc, LocalNewsState>(
                builder: (context, state) {
              if (state is LocalNewsLoaded) {
                return LocalNewsCarousel(
                  articles: state.articles,
                  isManageMode: true,
                  onEdit: _editNews,
                  onDelete: (article) => {
                    context.read<LocalNewsBloc>().add(DeleteNews(article.id))
                  },
                );
              } else if (state is LocalNewsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
