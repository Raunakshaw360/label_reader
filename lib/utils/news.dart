import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String _apiKey = '56bdbde21f3444f2b4d02d4c664f528f';
  final String _baseUrl = 'https://newsapi.org/v2/everything'; // Use 'everything' endpoint

  Future<List<NewsArticle>> fetchFoodNews() async {
    final response = await http.get(Uri.parse('$_baseUrl?q=food&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'ok' && data['articles'] is List) {
        final articles = data['articles'] as List;
        return articles.map((article) => NewsArticle.fromJson(article)).toList();
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load news: ${response.reasonPhrase}');
    }
  }
}

class NewsArticle {
  final String title;
  final String description;
  final String? urlToImage;

  NewsArticle({
    required this.title,
    required this.description,
    this.urlToImage,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      urlToImage: json['urlToImage'] as String?,
    );
  }
}
