class NewsArticle {
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;

  NewsArticle({
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      author: json['author'], // Ba'zan null bo'lishi mumkin
      title: json['title'] ?? "No title",
      description: json['description'],
      url: json['url'] ?? "",
      urlToImage: json['urlToImage'], // Ba'zan null bo'lishi mumkin
      publishedAt: json['publishedAt'] ?? "",
      content: json['content'],
    );
  }
}
