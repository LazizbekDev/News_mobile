import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/data/models/news_article.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsArticle article;
  const NewsDetailScreen({super.key, required this.article});
  void _launchURL() async {
    final Uri url = Uri.parse(article.url);
    if (!await launchUrl(url)) {
      throw Exception("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = "Unknown Date";
    DateTime dateTime = DateTime.parse(article.publishedAt);
    formattedDate = DateFormat('yyyy-MM-DD HH:mm').format(dateTime);
    return Scaffold(
      appBar: AppBar(title: Text(article.source?.name ?? "News Source")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null)
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  article.urlToImage ?? "",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported,
                          size: 150, color: Colors.grey),
                    );
                  },
                ),
              ),
            const SizedBox(height: 10),
            Text(
              article.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  article.author ?? "Unknown author",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  formattedDate,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              article.description ?? "No description available",
              style: const TextStyle(fontSize: 16),
              maxLines: 4,
            ),
            const SizedBox(height: 10),
            Text(
              article.content ?? "No content available",
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              maxLines: 15,
            ),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton.icon(
                onPressed: _launchURL,
                icon: const Icon(Icons.open_in_browser),
                label: const Text("Read More"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
