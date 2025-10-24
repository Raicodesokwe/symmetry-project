import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symmetryproject/features/articles/domain/usecases/get_articles.dart';
import 'package:symmetryproject/features/articles/presentation/bloc/articles_event.dart';
import 'package:symmetryproject/features/articles/presentation/bloc/articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final GetArticles getArticles;

  ArticlesBloc({required this.getArticles}) : super(ArticlesInitial()) {
    on<FetchArticles>(_onFetchArticles);
  }

  Future<void> _onFetchArticles(
    FetchArticles event,
    Emitter<ArticlesState> emit,
  ) async {
    emit(ArticlesLoading());
    final result = await getArticles();
    result.fold(
      (failure) => emit(ArticlesError(message: failure.message)),
      (articles) => emit(ArticlesLoaded(articles)),
    );
  }
}