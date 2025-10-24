

import 'package:injectable/injectable.dart';

import '../../domain/entities/article.dart';

@lazySingleton
class ArticleLocalDataSource {
  List<Article> getMockArticles() {
    return [
  Article(
    id: '1',
    title: 'Flutter 3.24 Released with New Performance Tools',
    content: 'The latest version of Flutter introduces enhanced DevTools, improved memory management, and better support for foldable devices. Developers can now profile GPU usage directly in the IDE.',
    newsImageUrl: 'https://picsum.photos/800/600?random=1',
    publishedAt: DateTime(2025, 10, 20, 14, 30),
    createdAt: DateTime(2025, 10, 19, 9, 0),
    updatedAt: DateTime(2025, 10, 20, 10, 15),
  ),
  Article(
    id: '2',
    title: 'Firebase Announces AI-Powered Analytics',
    content: 'Google Firebase now integrates with Vertex AI to provide predictive user behavior insights. This new feature helps developers anticipate churn and optimize engagement strategies.',
    newsImageUrl: 'https://picsum.photos/800/600?random=2',
    publishedAt: DateTime(2025, 10, 18, 11, 45),
    createdAt: DateTime(2025, 10, 17, 16, 20),
    updatedAt: null,
  ),
  Article(
    id: '3',
    title: 'Dart 3.6 Brings Records and Pattern Matching',
    content: 'Dart’s latest update enhances functional programming capabilities with full support for records and pattern matching, making code more expressive and less error-prone.',
    newsImageUrl: 'https://picsum.photos/800/600?random=3',
    publishedAt: DateTime(2025, 10, 15, 8, 0),
    createdAt: DateTime(2025, 10, 14, 13, 10),
    updatedAt: DateTime(2025, 10, 16, 9, 30),
  ),
];
  }
}
