import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:symmetryproject/core/errors/failures.dart';

import '../entities/article.dart';


abstract class ArticleRepository {
  Future<Either<Failure, List<Article>>> getArticles();
  Future<Either<Failure, void>> addArticle(Article article, File image);
}