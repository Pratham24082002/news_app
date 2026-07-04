import 'package:dio/dio.dart';
import 'package:news_app/core/constants/api_constants.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/data/models/article_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> fetchNews({
    required String category,
    required int page,
  });
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio dio;

  NewsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ArticleModel>> fetchNews({
    required String category,
    required int page,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.topHeadlines,
        queryParameters: {
          'country': 'us',
          'category': category.toLowerCase(),
          'page': page,
          'pageSize': ApiConstants.pageSize,
          'apiKey': ApiConstants.apiKey,
        },
      );

      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        final articles = response.data['articles'] as List;

        return articles
            .map((article) => ArticleModel.fromJson(article))
            .toList();
      } else {
        throw ServerException(
          response.data['message'] ?? 'Failed to fetch news',
        );
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Something went wrong');
    }
  }
}
