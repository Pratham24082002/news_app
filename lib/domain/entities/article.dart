import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String sourceName;
  final String author;
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String publishedAt;
  final String content;

  const Article({
    required this.sourceName,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
  });

  @override
  List<Object?> get props => [
    sourceName,
    author,
    title,
    description,
    url,
    imageUrl,
    publishedAt,
    content,
  ];
}
