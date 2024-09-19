part of 'article_cubit.dart';

@immutable
sealed class ArticleState {}

final class ArticleInitial extends ArticleState {}

final class ArticleLoading extends ArticleState{}

final class ArticleLoaded extends ArticleState{

  final List<Article> articles;

  ArticleLoaded({required this.articles});
}

final class ArticleFailed extends ArticleState{

  final String errorMessage;

  ArticleFailed({required this.errorMessage});
}
