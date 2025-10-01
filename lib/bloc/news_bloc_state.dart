import 'package:equatable/equatable.dart';

import 'package:news_app/model/news_article.dart';

abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsArticle> articles;

  NewsLoaded(this.articles);

  @override
  List<Object?> get props => [articles];
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);

  @override
  List<Object?> get props => [message];
}

class NewsOpenUrlFailure extends NewsState {
  final String message;
  NewsOpenUrlFailure(this.message);
}

class NewsOpenUrlSuccess extends NewsState {}
