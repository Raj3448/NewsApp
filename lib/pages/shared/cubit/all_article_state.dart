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

//Top Business
final class AllArticleBusinessLoading extends AllArticleState {}

final class AllArticleBusinessFailure extends AllArticleState {
  final String error;
  AllArticleBusinessFailure({required this.error});
}

final class AllArticleBusinessSuccess extends AllArticleState {
  final AllArticlesAboutTesla allArticlesAboutTesla;
  AllArticleBusinessSuccess({required this.allArticlesAboutTesla});
}

//Top Tech Crunch
final class AllArticleTechCruchLoading extends AllArticleState {}

final class AllArticleTechCruchFailure extends AllArticleState {
  final String error;
  AllArticleTechCruchFailure({required this.error});
}

final class AllArticleTechCruchSuccess extends AllArticleState {
  final AllArticlesAboutTesla allArticlesAboutTesla;
  AllArticleTechCruchSuccess({required this.allArticlesAboutTesla});
}

//sorted all
final class AllArticleSortedLoading extends AllArticleState {}

final class AllArticleSortedFailure extends AllArticleState {
  final String error;
  AllArticleSortedFailure({required this.error});
}

final class AllArticleSortedSuccess extends AllArticleState {
  final AllArticlesAboutTesla allArticlesAboutTesla;
  AllArticleSortedSuccess({required this.allArticlesAboutTesla});
}
