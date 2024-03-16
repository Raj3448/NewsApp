import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:headline_hub/constant/app_theme.dart';
import 'package:headline_hub/pages/shared/subwidgets/SavedNewsView_widget.dart';
import 'package:headline_hub/services/saved_news_isar_api.dart';
import 'package:lottie/lottie.dart';

class SavedNewsWidget extends StatefulWidget {
  const SavedNewsWidget({Key? key}) : super(key: key);

  @override
  State<SavedNewsWidget> createState() => _SavedNewsWidgetState();
}

class _SavedNewsWidgetState extends State<SavedNewsWidget> {
  bool replaceWidget = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        replaceWidget = true;
      });
    });
  }

  Widget getLoadingWidget() {
    return SingleChildScrollView(
      child: Animate(
        child: LottieBuilder.asset(
          'assets/animations/loader_view.json',
          fit: BoxFit.cover,
        ),
      ).animate().flip().shimmer(
          color: const Color(0xFFC2C1C1), duration: const Duration(seconds: 5)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
        future: SavedNewsIsarApi().getIsarSavedNewsModelList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            SingleChildScrollView(
              child: Animate(
                child: LottieBuilder.asset(
                  'assets/animations/loader_view.json',
                  fit: BoxFit.cover,
                ),
              ).animate().flip().shimmer(
                  color: const Color(0xFFC2C1C1),
                  duration: const Duration(seconds: 5)),
            );
          }
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          if (snapshot.data!.isEmpty) {
            return replaceWidget
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieBuilder.asset(
                        'assets/animations/empty.json',
                        height: 200,
                      ),
                      const Text(
                        'No Saved News Yet...!',
                        style: AppTheme.displayLarge,
                      ),
                    ],
                  )
                : getLoadingWidget();
          }
          return replaceWidget
              ? SizedBox(
                  height: screenSize.height * 0.5,
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: ((context, index) {
                        return SavedNewsViewWidget(
                          savedArticle: snapshot.data![index].myArticle,
                        );
                      })))
              : getLoadingWidget();
        });
  }
}
