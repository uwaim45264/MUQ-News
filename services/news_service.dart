// File: services/news_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsService {
  final String _apiKey = '558a5ca1beed46f3bcf177c0db14fd03';

  Future<List<NewsArticle>> fetchNews(String query) async {
    final String _baseUrl = 'https://newsapi.org/v2/everything';

    // Dynamically calculate the date for the last 7 days
    final String fromDate = DateTime.now()
        .subtract(const Duration(days: 7))
        .toIso8601String()
        .split('T')
        .first;

    // Construct the API URL
    final response = await http.get(
      Uri.parse('$_baseUrl?q=$query&from=$fromDate&sortBy=publishedAt&apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List articles = data['articles'];
      return articles.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
