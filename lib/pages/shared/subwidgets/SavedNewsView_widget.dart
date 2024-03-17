import 'package:flutter/material.dart';
import 'package:headline_hub/constant/app_theme.dart';
import 'package:headline_hub/model/isardb/saved_new_dto.dart';
import 'package:headline_hub/pages/home/NewsDetailsViewPage.dart';
import 'package:intl/intl.dart';
import 'package:zapx/zapx.dart';

class SavedNewsViewWidget extends StatelessWidget {
  MyArticle savedArticle;
  SavedNewsViewWidget({
    super.key,
    required this.savedArticle,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.bounceInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) {
              return NewsDetailsViewPage(
                article: savedArticle,
                savedNewDto: SavedNewDto(myArticle: MyArticle()),
                isFav: true,
              );
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: screenSize.width * 0.8,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 238, 238),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 110,
              width: 110,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                savedArticle.urlToImage ??
                    'https://static.vecteezy.com/system/resources/thumbnails/004/216/831/original/3d-world-news-background-loop-free-video.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                    child: Text(
                      savedArticle.title!,
                      style: AppTheme.copyWith(
                        color: AppTheme.primaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    DateFormat('E, dd/MM/yyyy')
                        .format(savedArticle.publishedAt ?? DateTime.now()),
                    style: AppTheme.copyWith(
                        //fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppTheme.primaryColor),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.favorite,
              color: AppTheme.primaryColor,
              size: 30,
            ).paddingOnly(right: 10, left: 5),
          ],
        ),
        // child: ListTile(
        //   leading: Container(
        //     height: 100,
        //     //width: 100,
        //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        //     clipBehavior: Clip.antiAlias,
        //     child: Image.network(
        //       savedArticle.urlToImage!,
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   title: SizedBox(
        //       height: 30,
        //       child: Text(
        //         savedArticle.title!,
        //         style: AppTheme.displayLarge,
        //         overflow: TextOverflow.ellipsis,
        //       )),
        //   subtitle: Text(
        //     DateFormat('E, dd/MM/yyyy')
        //         .format(savedArticle.publishedAt ?? DateTime.now()),
        //     style: AppTheme.copyWith(
        //         fontWeight: FontWeight.w600,
        //         fontSize: 14,
        //         color: AppTheme.primaryColor),
        //   ),
        //   trailing: const Icon(
        //     Icons.favorite,
        //     color: AppTheme.primaryColor,
        //     size: 30,
        //   ),
        // ),
      ),
    );
  }
}
