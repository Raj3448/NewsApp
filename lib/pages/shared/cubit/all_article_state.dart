part of 'all_article_cubit.dart';

@immutable
sealed class AllArticleState {}

final class AllArticleInitial extends AllArticleState {}

final class AllArticleLoading extends AllArticleState {}

final class AllArticleFailure extends AllArticleState {
  final String error;
  AllArticleFailure({required this.error});
}

final class AllArticleSuccess extends AllArticleState {
  final AllArticlesAboutTesla allArticlesAboutTesla;
  AllArticleSuccess({required this.allArticlesAboutTesla});
}
