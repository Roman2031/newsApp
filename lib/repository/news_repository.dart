import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/model/news_article.dart';

class NewsRepository {
  final Dio _dio = Dio();
  final String baseUrl = dotenv.env['BASE_URL'] ?? 'default_url';
  final String apiKey = dotenv.env['API_KEY'] ?? 'default_key';

  Future<List<NewsArticle>> fetchNews() async {
    final response = await _dio.get(
      baseUrl,
      queryParameters: {'country': 'us', 'apiKey': apiKey},
    );

    if (response.statusCode == 200) {
      final List articles = response.data['articles'];
      return articles.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
