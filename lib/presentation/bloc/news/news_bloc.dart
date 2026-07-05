import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/api_constants.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/domain/entities/article.dart';
import 'package:news_app/domain/repositories/news_repository.dart';

import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;

  NewsBloc({required this.repository}) : super(const NewsInitial()) {
    on<FetchNews>(_onFetchNews);
    on<LoadMoreNews>(_onLoadMoreNews);
    on<RefreshNews>(_onRefreshNews);
    on<SearchNews>(_onSearchNews);
  }

  Future<void> _onFetchNews(FetchNews event, Emitter<NewsState> emit) async {
    emit(const NewsLoading());

    try {
      final articles = await repository.fetchNews(
        category: event.category,
        page: 1,
      );

      emit(
        NewsLoaded(
          articles: articles,
          hasReachedMax: articles.length < ApiConstants.pageSize,
          currentPage: 1,
          category: event.category,
        ),
      );
    } on NoInternetException catch (e) {
      emit(NewsError(e.message));
    } on ServerException catch (e) {
      emit(NewsError(e.message));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  Future<void> _onLoadMoreNews(
    LoadMoreNews event,
    Emitter<NewsState> emit,
  ) async {
    if (state is! NewsLoaded) return;

    final currentState = state as NewsLoaded;

    if (currentState.hasReachedMax) return;

    try {
      final nextPage = currentState.currentPage + 1;

      final newArticles = await repository.fetchNews(
        category: event.category,
        page: nextPage,
      );

      final updatedArticles = List<Article>.from(currentState.articles)
        ..addAll(newArticles);

      emit(
        currentState.copyWith(
          articles: updatedArticles,
          currentPage: nextPage,
          hasReachedMax: newArticles.length < ApiConstants.pageSize,
        ),
      );
    } on NoInternetException catch (e) {
      emit(NewsError(e.message));
    } on ServerException catch (e) {
      emit(NewsError(e.message));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  Future<void> _onRefreshNews(
    RefreshNews event,
    Emitter<NewsState> emit,
  ) async {
    try {
      final articles = await repository.fetchNews(
        category: event.category,
        page: 1,
      );

      emit(
        NewsLoaded(
          articles: articles,
          hasReachedMax: articles.length < ApiConstants.pageSize,
          currentPage: 1,
          category: event.category,
        ),
      );
    } on NoInternetException catch (e) {
      emit(NewsError(e.message));
    } on ServerException catch (e) {
      emit(NewsError(e.message));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  Future<void> _onSearchNews(SearchNews event, Emitter<NewsState> emit) async {
    if (event.query.trim().isEmpty) {
      emit(const NewsInitial());
      return;
    }

    emit(const NewsLoading());

    try {
      final articles = await repository.searchNews(query: event.query, page: 1);

      emit(
        NewsLoaded(
          articles: articles,
          currentPage: 1,
          hasReachedMax: articles.length < ApiConstants.pageSize,
          category: '',
        ),
      );
    } on NoInternetException catch (e) {
      emit(NewsError(e.message));
    } on ServerException catch (e) {
      emit(NewsError(e.message));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
