import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/models/local_news_article.dart';
import 'package:news_app/widgets/image_from_file.dart';

class LocalNewsCarousel extends StatelessWidget {
  final List<LocalNewsArticle> articles;
  final bool isManageMode;
  final void Function(LocalNewsArticle)? onEdit;
  final void Function(LocalNewsArticle)? onDelete;

  const LocalNewsCarousel({
    super.key,
    required this.articles,
    this.isManageMode = false,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: articles.map((article) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ImageFromFile(
                imagePath: article.imageUrl,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      article.description ?? "No description available",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (isManageMode) _buildManageIcons(article),
                  ],
                ),
              ),
            ),
          ],
        );
      }).toList(),
      options: CarouselOptions(
        height: 220.0,
        autoPlay: !isManageMode,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        aspectRatio: 16 / 9,
      ),
    );
  }

  Widget _buildManageIcons(LocalNewsArticle article) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.white),
          onPressed: () => onEdit?.call(article),
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => onDelete?.call(article),
        ),
      ],
    );
  }
}
