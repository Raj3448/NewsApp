import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline_hub/pages/shared/cubit/all_article_cubit.dart';
import 'package:lottie/lottie.dart';

import '../subwidgets/post_view_widget.dart';

class EverythingArticle extends StatelessWidget {
  const EverythingArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<AllArticleCubit>().fetchSortedArticle(),
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
          return Center(
              child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
                    clipBehavior: Clip.antiAlias,
            child: ListView.builder(
                itemCount: snapshot.data!.articles.length,
                itemBuilder: (context, index) {
                  return PostViewWidget(
                      articles: snapshot.data!.articles[index]);
                }),
          ));
        });
  }
}
