
import 'package:news_app/domain/entities/article.dart';

class ArticleModel extends Article {
  const ArticleModel({
    required super.sourceName,
    required super.author,
    required super.title,
    required super.description,
    required super.url,
    required super.imageUrl,
    required super.publishedAt,
    required super.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      sourceName: json['source']?['name'] ?? 'Unknown',
      author: json['author'] ?? 'Unknown',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
    );
  }
}