import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class AddArticleEvent extends Equatable {
  const AddArticleEvent();

  @override
  List<Object?> get props => [];
}

class PublishArticle extends AddArticleEvent {
  final String title;
  final String content;
  final File image;

  const PublishArticle({
    required this.title,
    required this.content,
    required this.image,
  });

  @override
  List<Object?> get props => [title, content, image];
}