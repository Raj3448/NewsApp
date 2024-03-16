import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:headline_hub/constant/app_theme.dart';
import 'package:headline_hub/pages/shared/home_widget.dart';
import 'package:headline_hub/pages/shared/profile_widget.dart';
import 'package:headline_hub/pages/shared/saved_news_widget.dart';
import 'package:zapx/zapx.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FocusNode _searchFocusNode = FocusNode();
  final NotchBottomBarController _notchBottomBarController =
      NotchBottomBarController();
  late final List<Widget> _widgetList;
  final PageController _controller = PageController();
  @override
  void initState() {
    super.initState();
    _widgetList = [
      const HomeWidget(),
      const SavedNewsWidget(),
      const ProfileWidget()
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _notchBottomBarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var now = DateTime.now();
    var greeting = '';

    if (now.hour >= 0 && now.hour < 12) {
      greeting = 'Good Morning';
    } else if (now.hour >= 12 && now.hour < 16) {
      greeting = 'Good Afternoon';
    } else if (now.hour >= 16 && now.hour < 21) {
      greeting = 'Good Evening';
    } else {
      greeting = 'Good Night';
    }

    return Scaffold(
      extendBody: true,
      body: Column(
        children: [
          SizedBox(
            //height: screenSize.height * 0.21,
            child: Column(children: [
              ListTile(
                leading: const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
                title: const Text(
                  'Hi Raj',
                  style: AppTheme.displayMedium,
                ),
                subtitle: Text(
                  greeting,
                  style: AppTheme.copyWith(
                    fontSize: 18,
                    color: AppTheme.primaryColor,
                  ),
                ),
                trailing: const Icon(Icons.notifications_none_rounded,
                    color: AppTheme.primaryColor, size: 30),
              ).paddingOnly(top: 30, bottom: 10),
              SizedBox(
                height: screenSize.height * 0.06,
                width: screenSize.width * 0.9,
                child: TextFormField(
                  focusNode: _searchFocusNode,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search,
                          size: 30, color: Colors.grey),
                      fillColor: const Color.fromARGB(60, 199, 198, 198),
                      filled: true,
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: AppTheme.displayMedium,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 0.001),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 0.001),
                          borderRadius: BorderRadius.circular(10))),
                  onFieldSubmitted: (value) {
                    _searchFocusNode.unfocus();
                  },
                ),
              ),
            ]),
          ).paddingOnly(bottom: 10),
          Expanded(
            child: Container(
              //color: Colors.amber,
              child: PageView.builder(
                  itemCount: _widgetList.length,
                  pageSnapping: true,
                  controller: _controller,
                  onPageChanged: (index) {
                    _notchBottomBarController.jumpTo(index);
                  },
                  clipBehavior: Clip.antiAlias,
                  itemBuilder: (context, index) {
                    return Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(34),
                                bottomRight: Radius.circular(34))),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: _widgetList[index]);
                  }),
            ).paddingOnly(bottom: 7),
          )
        ],
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _notchBottomBarController,
        blurFilterX: 10,
        blurOpacity: 10,
        notchColor: AppTheme.primaryColor,
        onTap: (int index) {
          _notchBottomBarController.jumpTo(index);

          _controller.animateToPage(index,
              duration: const Duration(seconds: 1), curve: Curves.decelerate);
        },
        bottomBarItems: [
          const BottomBarItem(
            inActiveItem: Icon(
              Icons.home_filled,
              color: Color.fromARGB(255, 129, 144, 152),
            ),
            activeItem: Icon(
              Icons.home_filled,
              color: AppTheme.secondaryColor,
            ),
          ),
          const BottomBarItem(
            inActiveItem: Icon(
              Icons.star,
              color: Color.fromARGB(255, 129, 144, 152),
            ),
            activeItem: Icon(
              Icons.star,
              color: AppTheme.secondaryColor,
            ),
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.person,
              color: Color.fromARGB(255, 129, 144, 152),
            ),
            activeItem: Icon(
              Icons.person,
              color: AppTheme.secondaryColor,
            ),
          ),
        ],
        kIconSize: 20,
        kBottomRadius: 30,
      ),
    );
  }
}
