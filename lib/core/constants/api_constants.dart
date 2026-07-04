import 'package:news_app/core/constants/secrets.dart';

class ApiConstants {
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String topHeadlines = '/top-headlines';

  static const String apiKey = Secrets.newsApiKey;

  static const int pageSize = 10;
}