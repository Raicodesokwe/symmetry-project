import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:symmetryproject/core/errors/failures.dart';
import 'package:symmetryproject/features/articles/domain/entities/article.dart';
import 'package:symmetryproject/features/articles/domain/repositories/article_repository.dart';

@injectable
class AddArticle {
  final ArticleRepository repository;

  AddArticle(this.repository);

  Future<Either<Failure, void>> call(Article article, File image) async {
    return await repository.addArticle(article, image);
  }
}