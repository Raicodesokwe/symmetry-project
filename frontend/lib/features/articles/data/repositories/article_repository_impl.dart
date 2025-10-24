// lib/features/articles/data/repositories/article_repository_impl.dart
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:symmetryproject/core/errors/failures.dart';
import 'package:symmetryproject/features/articles/data/datasources/article_local_data_source.dart';
import 'package:symmetryproject/features/articles/domain/repositories/article_repository.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/entities/article.dart';

@LazySingleton(as: ArticleRepository)
class ArticleRepositoryImpl implements ArticleRepository {
  // local data
  final ArticleLocalDataSource localDataSource;
  // for real mode
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  final NetworkInfo networkInfo;

  ArticleRepositoryImpl({
    required this.localDataSource,
    @Named('firestore') required this.firestore,
    @Named('storage') required this.storage,
     required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Article>>> getArticles() async {
    try {
      // local data
      // Simulate delay
      // await Future.delayed(const Duration(milliseconds: 500));
      // final articles = localDataSource.getMockArticles();
      // real data from firestore
       final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(ServerFailure('No internet connection'));
    }
       final snapshot = await firestore.collection('articles').orderBy('published_at', descending: true).get();
      final articles = <Article>[];

      for (final doc in snapshot.docs) {
        final data = doc.data();
        articles.add(
          Article(
            id: doc.id,
            title: data['title'] as String,
            content: data['content'] as String,
            newsImageUrl: data['news_image_url'] as String,
            publishedAt: (data['published_at'] as Timestamp).toDate(),
            createdAt: data['created_at'] != null
                ? (data['created_at'] as Timestamp).toDate()
                : null,
            updatedAt: data['updated_at'] != null
                ? (data['updated_at'] as Timestamp).toDate()
                : null,
          ),
        );
      }
      return Right(articles);
    } catch (e) {
      return const Left(ServerFailure('Failed to load articles'));
    }
  }
  @override
  Future<Either<Failure, void>> addArticle(Article article, File image) async {
    try {
       final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(ServerFailure('No internet connection'));
    }
      final fileName = '${article.id}_${DateTime.now().millisecondsSinceEpoch}';
      final ref = storage.ref().child('article_images/$fileName.jpg');
      final uploadTask = ref.putFile(image);
      final snapshot = await uploadTask;
      final imageUrl = await snapshot.ref.getDownloadURL();

      final docRef = firestore.collection('articles').doc();
      final newArticle = Article(
        id: docRef.id,
        title: article.title,
        content: article.content,
        newsImageUrl: imageUrl,
        publishedAt: article.publishedAt,
        createdAt: DateTime.now(),
      );

      await docRef.set({
        'title': newArticle.title,
        'content': newArticle.content,
        'news_image_url': newArticle.newsImageUrl,
        'published_at': newArticle.publishedAt,
        'created_at': newArticle.createdAt,
      });

      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure('Failed to publish article: $e'));
    }
  }
}