import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:headline_hub/constant/app_theme.dart';

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
                  unselectedLabelStyle: TextStyle(color: Colors.black),
                  labelStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: [
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
                children: <Widget>[
                  Center(
                    child: FutureBuilder(
                      future: , builder: ((context, snapshot) => )),
                  ),
                  Center(
                    child: Icon(Icons.directions_transit),
                  ),
                  Center(
                    child: Icon(Icons.directions_bike),
                  ),
                  Center(
                    child: Icon(Icons.directions_car),
                  ),
                
                ],
              ),
            ),
          ],
        ));
  }
}
