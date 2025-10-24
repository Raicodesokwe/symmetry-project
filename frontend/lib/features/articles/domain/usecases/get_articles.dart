
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/article_repository.dart';
import '../entities/article.dart';

@lazySingleton
class GetArticles {
  final ArticleRepository repository;

  GetArticles(this.repository);

  Future<Either<Failure, List<Article>>> call() async {
    return await repository.getArticles();
  }
}