
import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../services/news_service.dart';

class NewsProvider with ChangeNotifier {
  final NewsService _newsService = NewsService();
  List<NewsArticle> _articles = [];
  bool _isLoading = true;

  List<NewsArticle> get articles => _articles;
  bool get isLoading => _isLoading;

  NewsProvider() {
    fetchNews('tesla'); // Default topic
  }

  Future<void> fetchNews(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await _newsService.fetchNews(query);
    } catch (e) {
      // Handle errors here
    }

    _isLoading = false;
    notifyListeners();
  }

  fetchMoreNews(String lastQuery) {}
}
