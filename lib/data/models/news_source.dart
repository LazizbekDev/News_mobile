class NewsSource {
  final String? id;
  final String name;

  NewsSource({this.id, required this.name});

  factory NewsSource.fromJson(Map<String, dynamic> json) {
    return NewsSource(
      id: json['id'],
      name: json['name'],
    );
  }
}
