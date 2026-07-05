import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/network/dio_client.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/data/datasource/remote/news_remote_datasource.dart';
import 'package:news_app/data/repositories/news_repository_impl.dart';
import 'package:news_app/domain/entities/article.dart';
import 'package:news_app/presentation/bloc/news/news_bloc.dart';
import 'package:news_app/presentation/screens/article/article_screen.dart';
import 'package:news_app/presentation/screens/category/category_screen.dart';
import 'package:news_app/presentation/screens/home/home_screen.dart';
import 'package:news_app/presentation/screens/splash/splash_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String category = '/category';
  static const String article = '/article';
  static const String splash = '/splash';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );

      case category:
        final categoryData = settings.arguments as Map<String, dynamic>;
        final dio = DioClient.createDio();
        final connectivity = Connectivity();

        final networkInfo = NetworkInfoImpl(connectivity);
        final remoteDataSource = NewsRemoteDataSourceImpl(dio);

        final repository = NewsRepositoryImpl(
          remoteDataSource: remoteDataSource,
          networkInfo: networkInfo,
        );

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => NewsBloc(repository: repository),
            child: CategoryScreen(category: categoryData),
          ),
        );

      case article:
        final article = settings.arguments as Article;

        return MaterialPageRoute(
          builder: (_) => ArticleScreen(article: article),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route found for ${settings.name}'),
            ),
          ),
        );
    }
  }
}