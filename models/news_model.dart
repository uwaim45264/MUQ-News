// File: models/news_model.dart
class NewsArticle {
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String publishedAt;
  final String? content; // Optional field for full content
  final String category; // New field for category

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    this.content, // Optional field
    required this.category, // Constructor includes category
  });

  // Factory constructor to parse JSON data
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? "No Title",
      description: json['description'] ?? "No Description",
      url: json['url']?.trim() ?? "",
      imageUrl: json['urlToImage']?.trim() ?? "",
      publishedAt: json['publishedAt'] ?? "Unknown Date",
      content: json['content'], // Parses content if available
      category: json['category'] ?? "General", // Use default if category not provided
    );
  }

  @override
  String toString() {
    return 'NewsArticle(title: $title, description: $description, url: $url, '
        'imageUrl: $imageUrl, publishedAt: $publishedAt, content: $content, category: $category)';
  }
}
