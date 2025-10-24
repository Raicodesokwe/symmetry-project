import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/article.dart';
import '../../domain/usecases/add_article.dart';
import 'add_article_event.dart';
import 'add_article_state.dart';

@injectable
class AddArticleBloc extends Bloc<AddArticleEvent, AddArticleState> {
  final AddArticle addArticle;

  AddArticleBloc(this.addArticle) : super(AddArticleInitial()) {
    on<PublishArticle>(_onPublishArticle);
  }

  Future<void> _onPublishArticle(
    PublishArticle event,
    Emitter<AddArticleState> emit,
  ) async {
    emit(AddArticleLoading());

    final article = Article.empty().copyWith(
      title: event.title,
      content: event.content,
      publishedAt: DateTime.now(),
    );

    final result = await addArticle(article, event.image);
    
    result.fold(
      (failure) => emit(AddArticleError(failure.message)),
      (_) => emit(AddArticleSuccess()),
    );
  }
}