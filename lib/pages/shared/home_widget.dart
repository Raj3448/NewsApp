import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

import 'package:headline_hub/constant/app_theme.dart';

import 'package:headline_hub/pages/shared/widgets/all_article_display.dart';
import 'package:headline_hub/pages/shared/widgets/business_article.dart';
import 'package:headline_hub/pages/shared/widgets/everything_article.dart';
import 'package:headline_hub/pages/shared/widgets/tech_crunch_article.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
        length: 4,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: ButtonsTabBar(
                  controller: _controller,
                  duration: 1,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 19),
                  backgroundColor: AppTheme.primaryColor,
                  unselectedBackgroundColor: Colors.grey[300],
                  unselectedLabelStyle:
                      const TextStyle(color: AppTheme.primaryColor),
                  labelStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(
                      text: "All articles",
                    ),
                    Tab(
                      text: "Top business",
                    ),
                    Tab(
                      text: "TechCrunch",
                    ),
                    Tab(
                      text: "Education",
                    ),
                  ]),
            ),
            Expanded(
                child: TabBarView(
              controller: _controller,
              children: const <Widget>[
                AllArticleDisplay(),
                BusinessArticle(),
                TechCrunchArticle(),
                EverythingArticle()
                
              ],
            )),
          ],
        ));
  }
}
