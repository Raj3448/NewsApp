import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline_hub/pages/shared/cubit/all_article_cubit.dart';
import 'package:headline_hub/pages/shared/subwidgets/post_view_widget.dart';
import 'package:lottie/lottie.dart';

class AllArticleDisplay extends StatelessWidget {
  const AllArticleDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<AllArticleCubit>().fetchAllArticle(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LottieBuilder.asset(
                'assets/animations/loading.json',
                height: 90,
                
              ),
            );
          }
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
                itemCount: snapshot.data!.articles.length,
                itemBuilder: (context, index) {
                  return PostViewWidget(
                      articles: snapshot.data!.articles[index]);
                }),
          );
        });
  }
}