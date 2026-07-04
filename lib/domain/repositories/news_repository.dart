import 'package:news_app/domain/entities/article.dart';

abstract class NewsRepository {
  Future<List<Article>> fetchNews({
    required String category,
    required int page,
  });
}