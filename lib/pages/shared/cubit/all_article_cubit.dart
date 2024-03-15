import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline_hub/model/allarticle_tesla_dto.dart';
import 'package:dio/dio.dart';

part 'all_article_state.dart';

class AllArticleCubit extends Cubit<AllArticleState> {
  AllArticleCubit() : super(AllArticleInitial());

  final dio = Dio();

  Future<AllArticlesAboutTesla?> fetchAllArticle() async {
    try {
      emit(AllArticleLoading());

      Response response = await dio.get(
        'https://newsapi.org/v2/everything?q=tesla&from=2024-02-14&sortBy=publishedAt&apiKey=6d2dc790e99a493193ba17be295e1490',
      );

      if (response.statusCode == 200) {
        print('Received Response : ${response.data.toString()}');
        print('Hey Iam here');
        final AllArticlesAboutTesla all = AllArticlesAboutTesla.fromJson(
            response.data as Map<String, dynamic>);
        print('Received Object total result : ${all.totalResults}');

        return AllArticlesAboutTesla.fromJson(response.data);
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

  Future<AllArticlesAboutTesla?> fetchBusinessArticle() async {
    try {
      emit(AllArticleBusinessLoading());

      Response response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=6d2dc790e99a493193ba17be295e1490',
      );

      if (response.statusCode == 200) {
        print('Received Business Response : ${response.data.toString()}');
        print('Hey Iam here');
        final AllArticlesAboutTesla all = AllArticlesAboutTesla.fromJson(
            response.data as Map<String, dynamic>);
        print('Received Object total result : ${all.totalResults}');
        emit(AllArticleBusinessSuccess(
          allArticlesAboutTesla: AllArticlesAboutTesla.fromJson(response.data),
        ));
        return AllArticlesAboutTesla.fromJson(response.data);
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

  Future<AllArticlesAboutTesla?> fetchTechCruchArticle() async {
    try {
      emit(AllArticleTechCruchLoading());

      Response response = await dio.get(
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=6d2dc790e99a493193ba17be295e1490',
      );

      if (response.statusCode == 200) {
        print('Received TechCruch Response : ${response.data.toString()}');
        print('Hey Iam here');
        final AllArticlesAboutTesla all = AllArticlesAboutTesla.fromJson(
            response.data as Map<String, dynamic>);
        print('Received Object total result : ${all.totalResults}');
        emit(AllArticleTechCruchSuccess(
          allArticlesAboutTesla: AllArticlesAboutTesla.fromJson(response.data),
        ));
        return AllArticlesAboutTesla.fromJson(response.data);
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

  Future<AllArticlesAboutTesla?> fetchSortedArticle() async {
    try {
      emit(AllArticleSortedLoading());

      Response response = await dio.get(
        'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=6d2dc790e99a493193ba17be295e1490',
      );

      if (response.statusCode == 200) {
        print('Received sorted Response : ${response.data.toString()}');
        print('Hey Iam here');
        final AllArticlesAboutTesla all = AllArticlesAboutTesla.fromJson(
            response.data as Map<String, dynamic>);
        print('Received Object total result : ${all.totalResults}');
        emit(AllArticleSortedSuccess(
          allArticlesAboutTesla: AllArticlesAboutTesla.fromJson(response.data),
        ));
        return AllArticlesAboutTesla.fromJson(response.data);
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
