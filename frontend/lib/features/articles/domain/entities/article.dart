import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String id;
  final String title;
  final String content;
  final String newsImageUrl;
  final DateTime publishedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Article({
    required this.id,
    required this.title,
    required this.content,
    required this.newsImageUrl,
    required this.publishedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Article.empty() => Article(
        id: '',
        title: '',
        content: '',
        newsImageUrl: '',
        publishedAt: DateTime.now(),
      );

  Article copyWith({
    String? id,
    String? title,
    String? content,
    String? newsImageUrl,
    DateTime? publishedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Article(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      newsImageUrl: newsImageUrl ?? this.newsImageUrl,
      publishedAt: publishedAt ?? this.publishedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        newsImageUrl,
        publishedAt,
        createdAt,
        updatedAt,
      ];
}