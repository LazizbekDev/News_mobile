import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/data/models/news_response.dart';

class NewsRepository {
  static const String apiKey = "25cea407e57d4134a19f2dac873abfea";
  static const String baseUrl = "https://newsapi.org/v2/everything";

  Future<NewsResponse> fetchNews(String query) async {
    final url = Uri.parse(
        "$baseUrl?q=$query&from=2025-02-12&sortBy=publishedAt&apiKey=$apiKey");

    try {
      final response = await http.get(url);

      debugPrint(
          "API Response: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData["status"] != "ok") {
          throw Exception("API status is not 'ok': ${jsonData['status']}");
        }

        return NewsResponse.fromJson(jsonData);
      } else {
        throw Exception(
            "Failed to load news: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      throw Exception("Error fetching news: $e");
    }
  }
}
