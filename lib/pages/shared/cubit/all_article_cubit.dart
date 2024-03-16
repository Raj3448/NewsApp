import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline_hub/model/allarticle_tesla_dto.dart';
import 'package:dio/dio.dart';
import 'package:headline_hub/model/allarticle_tesla_dto.dart';


part 'all_article_state.dart';

class AllArticleCubit extends Cubit<AllArticleState> {
  AllArticleCubit() : super(AllArticleInitial());

  final dio = Dio();

  Future<AllArticlesDto?> fetchAllArticle() async {
    try {
      emit(AllArticleLoading());

      Response response = await dio.get(
        'https://newsapi.org/v2/everything?q=apple&from=2024-03-13&to=2024-03-13&sortBy=popularity&apiKey=6d2dc790e99a493193ba17be295e1490',
      );

      if (response.statusCode == 200) {
        print('Received Response : ${response.data.toString()}');
        print('Hey Iam here');
        final AllArticlesDto all = AllArticlesDto.fromJson(
            response.data as Map<String, dynamic>);
        print('Received Object total result : ${all.totalResults}');

        return AllArticlesDto.fromJson(response.data);
      } else {
        print('failed to fetch article');
        emit(AllArticleFailure(
            error: 'Failed to fetch articles: ${response.statusCode}'));
      }
    } catch (e) {
      print('Error Here: $e');
      emit(AllArticleFailure(error: 'Error fetching articles: $e'));
    }
    return null;
  }

  Future<AllArticlesDto?> fetchBusinessArticle() async {
    try {
      emit(AllArticleBusinessLoading());

      Response response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=6d2dc790e99a493193ba17be295e1490',
      );

      if (response.statusCode == 200) {
        print('Received Business Response : ${response.data.toString()}');
        print('Hey Iam here');
        final AllArticlesDto all = AllArticlesDto.fromJson(
            response.data as Map<String, dynamic>);
        print('Received Object total result : ${all.totalResults}');
        emit(AllArticleBusinessSuccess(
          allArticlesDto: AllArticlesDto.fromJson(response.data),
        ));
        return AllArticlesDto.fromJson(response.data);
      } else {
        print('failed to fetch article');
        emit(AllArticleBusinessFailure(
            error: 'Failed to fetch articles: ${response.statusCode}'));
      }
    } catch (e) {
      print('Error Here: $e');
      emit(AllArticleBusinessFailure(error: 'Error fetching articles: $e'));
    }
    return null;
  }

  Future<AllArticlesDto?> fetchTechCruchArticle() async {
    try {
      emit(AllArticleTechCruchLoading());

      Response response = await dio.get(
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=6d2dc790e99a493193ba17be295e1490',
      );

      if (response.statusCode == 200) {
        print('Received TechCruch Response : ${response.data.toString()}');
        print('Hey Iam here');
        final AllArticlesDto all = AllArticlesDto.fromJson(
            response.data as Map<String, dynamic>);
        print('Received Object total result : ${all.totalResults}');
        emit(AllArticleTechCruchSuccess(
          allArticlesDto: AllArticlesDto.fromJson(response.data),
        ));
        return AllArticlesDto.fromJson(response.data);
      } else {
        print('failed to fetch article');
        emit(AllArticleTechCruchFailure(
            error: 'Failed to fetch articles: ${response.statusCode}'));
      }
    } catch (e) {
      print('Error Here: $e');
      emit(AllArticleTechCruchFailure(error: 'Error fetching articles: $e'));
    }
    return null;
  }

  Future<AllArticlesDto?> fetchSortedArticle() async {
    try {
      emit(AllArticleSortedLoading());

      Response response = await dio.get(
        'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=6d2dc790e99a493193ba17be295e1490',
      );

      if (response.statusCode == 200) {
        print('Received sorted Response : ${response.data.toString()}');
        print('Hey Iam here');
        final AllArticlesDto all = AllArticlesDto.fromJson(
            response.data as Map<String, dynamic>);
        print('Received Object total result : ${all.totalResults}');
        emit(AllArticleSortedSuccess(
          allArticlesDto: AllArticlesDto.fromJson(response.data),
        ));
        return AllArticlesDto.fromJson(response.data);
      } else {
        print('failed to fetch article');
        emit(AllArticleSortedFailure(
            error: 'Failed to fetch articles: ${response.statusCode}'));
      }
    } catch (e) {
      print('Error Here: $e');
      emit(AllArticleSortedFailure(error: 'Error fetching articles: $e'));
    }
    return null;
  }
}
