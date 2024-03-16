// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:headline_hub/constant/app_theme.dart';
import 'package:headline_hub/model/isardb/saved_new_dto.dart';
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
    return Container(
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              savedArticle.urlToImage!,
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
    );
  }
}
