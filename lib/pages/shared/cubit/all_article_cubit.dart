import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline_hub/model/allarticle_tesla_dto.dart';
import 'package:dio/dio.dart';

part 'all_article_state.dart';

class AllArticleCubit extends Cubit<AllArticleState> {
  AllArticleCubit() : super(AllArticleInitial());

  final dio = Dio();
  void getHttp() async {
    final response = await dio.get('https://newsapi.org/v2/everything?q=tesla&from=2024-02-14&sortBy=publishedAt&apiKey=3cfdfafaadeb460588fcdcaadcdf6f68');
    print(response);
  }

  Future<void> fetchAllArticle() async {
    emit(AllArticleLoading());
  }
}
