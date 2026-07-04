import 'package:equatable/equatable.dart';
import 'package:news_app/domain/entities/article.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {
  const NewsInitial();
}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsLoaded extends NewsState {
  final List<Article> articles;
  final bool hasReachedMax;
  final int currentPage;
  final String category;

  const NewsLoaded({
    required this.articles,
    required this.hasReachedMax,
    required this.currentPage,
    required this.category,
  });

  NewsLoaded copyWith({
    List<Article>? articles,
    bool? hasReachedMax,
    int? currentPage,
    String? category,
  }) {
    return NewsLoaded(
      articles: articles ?? this.articles,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [
    articles,
    hasReachedMax,
    currentPage,
    category,
  ];
}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object?> get props => [message];
}