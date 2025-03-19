import 'dart:io';
import 'package:flutter/material.dart';

class ImageFromFile extends StatelessWidget {
  final String? imagePath;
  const ImageFromFile({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    if (imagePath == null || imagePath!.isEmpty) {
      return _buildPlaceholderImage();
    }

    final filePath = imagePath!.startsWith('file://')
        ? Uri.parse(imagePath!).toFilePath()
        : imagePath!;
    final file = File(filePath);

    return file.existsSync()
        ? Image.file(
            file,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                _buildPlaceholderImage(),
          )
        : _buildPlaceholderImage();
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey,
      child: const Icon(
        Icons.image_not_supported,
        size: 150,
        color: Colors.grey,
      ),
    );
  }
}
