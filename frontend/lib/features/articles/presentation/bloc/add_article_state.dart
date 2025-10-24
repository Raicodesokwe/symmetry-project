import 'package:equatable/equatable.dart';

abstract class AddArticleState extends Equatable {
  const AddArticleState();

  @override
  List<Object?> get props => [];
}

class AddArticleInitial extends AddArticleState {}

class AddArticleLoading extends AddArticleState {}

class AddArticleSuccess extends AddArticleState {}

class AddArticleError extends AddArticleState {
  final String message;

  const AddArticleError(this.message);

  @override
  List<Object?> get props => [message];
}