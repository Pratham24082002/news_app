import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/data/datasource/remote/news_remote_datasource.dart';
import 'package:news_app/domain/entities/article.dart';
import 'package:news_app/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Article>> fetchNews({
    required String category,
    required int page,
  }) async {
    if (await networkInfo.isConnected) {
      return await remoteDataSource.fetchNews(category: category, page: page);
    } else {
      throw NoInternetException('No internet connection');
    }
  }

  @override
  Future<List<Article>> searchNews({
    required String query,
    required int page,
  }) async {
    if (!await networkInfo.isConnected) {
      throw NoInternetException('No internet connection');
    }

    return await remoteDataSource.searchNews(
      query: query,
      page: page,
    );
  }


}
