import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:news_app/data/models/news_response.dart';

class NewsRepository {
  final String apiKey = dotenv.env['API_KEY'] ?? "";
  final String baseUrl = dotenv.env['BASE_URL'] ?? "";
  // static const String baseUrl = "https://newsapi.org/v2/everything";

  Future<NewsResponse> fetchNews(String query) async {
    final String today = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(const Duration(days: 28)));

    final url = Uri.parse(
        "$baseUrl?q=$query&from=$today&sortBy=publishedAt&apiKey=$apiKey");

    try {
      final response = await http.get(url);

      // debugPrint(response.body);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData["status"] != "ok") {
          throw Exception("json status isn't okay: ${jsonData['status']}");
        }

        return NewsResponse.fromJson(jsonData);
      } else {
        throw Exception(
          "Failed to load news: ${response.statusCode} - ${response.body}",
        );
      }
    } catch (e) {
      throw Exception("Error fetching news: $e");
    }
  }
}
