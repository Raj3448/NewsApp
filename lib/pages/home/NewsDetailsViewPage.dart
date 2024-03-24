// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:headline_hub/constant/app_theme.dart';
import 'package:headline_hub/model/isardb/saved_new_dto.dart';
import 'package:headline_hub/services/saved_news_isar_api.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zapx/zapx.dart';

import '../../model/allarticle_tesla_dto.dart';

class NewsDetailsViewPage extends StatefulWidget {
  final dynamic article;
  SavedNewDto savedNewDto;
  bool isFav;
  NewsDetailsViewPage({
    Key? key,
    required this.article,
    required this.savedNewDto,
    required this.isFav,
  }) : super(key: key);

  @override
  State<NewsDetailsViewPage> createState() => _NewsDetailsViewPageState();
}

class _NewsDetailsViewPageState extends State<NewsDetailsViewPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _savedController;
  bool isSaved = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _savedController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    if (widget.isFav) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _savedController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30,
              color: AppTheme.primaryColor,
            )),
        centerTitle: true,
        title: const Text('News Details', style: AppTheme.displayLarge),
        actions: [
          GestureDetector(
            onTap: () {
              isSaved = !isSaved;

              if (isSaved) {
                _savedController.forward();
              } else {
                _savedController.reverse();
              }
            },
            child: LottieBuilder.asset(
              controller: _savedController,
              'assets/animations/saved.json',
              height: 50,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        clipBehavior: Clip.antiAlias,
                        child: Hero(
                          tag: 'rajkumar',
                          child: Image.network(
                            widget.article.urlToImage!,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          CustomPaint(
                            size: const Size(15, 15),
                            painter: DotPainter(color: Colors.black),
                          ).paddingOnly(right: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.article.author!.length > 45
                                    ? 'Raj Chavan'
                                    : widget.article.author!,
                                style: AppTheme.copyWith(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              Text(
                                DateFormat('E, dd/MM/yyyy')
                                    .format(widget.article.publishedAt),
                                style: AppTheme.copyWith(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              if (widget.isFav) {
                                MyArticle article = MyArticle();
                                article.author = article.author ?? 'Raj Chavan';
                                article.title = article.title ?? 'Title Here';
                                article.content =
                                    article.content ?? 'content here';
                                article.description =
                                    article.description ?? 'description here';
                                article.publishedAt = article.publishedAt;
                                article.url = article.url ??
                                    'https://dribbble.com/shots/18754171-News-Reading-Mobile-App';
                                article.urlToImage = article.urlToImage;
                                widget.savedNewDto =
                                    SavedNewDto(myArticle: article);
                                SavedNewsIsarApi().insert(widget.savedNewDto);
                                _controller.forward();
                              } else {
                                SavedNewsIsarApi()
                                    .delete(widget.savedNewDto.id.toString());
                                _controller.reverse();
                              }
                              setState(() {
                                widget.isFav = !widget.isFav;
                              });
                            },
                            child: LottieBuilder.asset(
                              'assets/animations/favorite.json',
                              height: 65,
                              fit: BoxFit.cover,
                              controller: _controller,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        widget.article.title!,
                        style: AppTheme.displayLarge,
                      ),
                    ),
                    Text(
                      widget.article.description!,
                      style: AppTheme.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: _launchURL,
              style: const ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(300, 70)),
                  backgroundColor:
                      MaterialStatePropertyAll(AppTheme.primaryColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Read More  ',
                    style: AppTheme.copyWith(color: Colors.white),
                  ),
                  LottieBuilder.asset(
                    'assets/animations/rocket.json',
                    height: 50,
                  )
                ],
              )).paddingOnly(bottom: 30)
        ],
      ),
    );
  }

  _launchURL() async {
    String url = widget.article.url!;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class DotPainter extends CustomPainter {
  final Color color;

  DotPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
