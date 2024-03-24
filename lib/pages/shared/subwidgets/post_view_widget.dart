import 'package:flutter/material.dart';
import 'package:headline_hub/constant/app_theme.dart';
import 'package:headline_hub/model/allarticle_tesla_dto.dart';
import 'package:headline_hub/model/isardb/saved_new_dto.dart';
import 'package:headline_hub/pages/home/NewsDetailsViewPage.dart';
import 'package:headline_hub/services/saved_news_isar_api.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:zapx/zapx.dart';

class PostViewWidget extends StatefulWidget {
  final Article articles;
  const PostViewWidget({Key? key, required this.articles}) : super(key: key);

  @override
  State<PostViewWidget> createState() => _PostViewWidgetState();
}

class _PostViewWidgetState extends State<PostViewWidget>
    with SingleTickerProviderStateMixin {
  bool _isFav = false;
  late AnimationController _controller;
  late SavedNewDto savedNewDto;
  String defaultImageUrl =
      'https://static.vecteezy.com/system/resources/thumbnails/004/216/831/original/3d-world-news-background-loop-free-video.jpg';

  @override
  void initState() {
    super.initState();
    //temp Initialized (He kay kamach nahiy)
    savedNewDto = SavedNewDto(myArticle: MyArticle());
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            // transitionsBuilder:
            //     (context, animation, secondaryAnimation, child) {
            //   var begin = const Offset(1.0, 0.0);
            //   var end = Offset.zero;
            //   var curve = Curves.bounceInOut;
            //   var tween =
            //       Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            //   var offsetAnimation = animation.drive(tween);
            //   return SlideTransition(
            //     position: offsetAnimation,
            //     child: child,
            //   );
            // },
            pageBuilder: (context, animation, secondaryAnimation) {
              return NewsDetailsViewPage(
                article: widget.articles,
                savedNewDto: savedNewDto,
                isFav: _isFav,
              );
            },
          ),
        );
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: screenSize.height * 0.42,
            width: screenSize.width * 0.9,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: widget.articles.urlToImage == null
                ? Hero(
                    tag: 'rajkumar',
                    child: Image.network(defaultImageUrl, fit: BoxFit.cover))
                : Image.network(
                    widget.articles.urlToImage!,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(
            height: screenSize.height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 100,
                          padding: const EdgeInsets.only(left: 10),
                          decoration: const BoxDecoration(
                              color: Colors.black54,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              DateFormat('E, dd/MM/yyyy').format(
                                  widget.articles.publishedAt ??
                                      DateTime.now()),
                              style: AppTheme.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white60),
                            ).paddingAll(3),
                          ),
                        ).paddingOnly(left: 20),
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black54, blurRadius: 10)
                                  ]),
                              child: GestureDetector(
                                onTap: () {
                                  if (_isFav) {
                                    MyArticle article = MyArticle();
                                    article.author =
                                        widget.articles.author ?? 'Raj Chavan';
                                    article.title =
                                        widget.articles.title ?? 'Title Here';
                                    article.content = widget.articles.content ??
                                        'content here';
                                    article.description =
                                        widget.articles.description ??
                                            'description here';
                                    article.publishedAt =
                                        widget.articles.publishedAt;
                                    article.url = widget.articles.url ??
                                        'https://dribbble.com/shots/18754171-News-Reading-Mobile-App';
                                    article.urlToImage =
                                        widget.articles.urlToImage ??
                                            defaultImageUrl;
                                    savedNewDto =
                                        SavedNewDto(myArticle: article);
                                    SavedNewsIsarApi().insert(savedNewDto);
                                    _controller.forward();
                                  } else {
                                    SavedNewsIsarApi()
                                        .delete(savedNewDto.id.toString());
                                    _controller.reverse();
                                  }
                                  setState(() {
                                    _isFav = !_isFav;
                                  });
                                },
                                child: LottieBuilder.asset(
                                  'assets/animations/favorite.json',
                                  height: 65,
                                  fit: BoxFit.cover,
                                  controller: _controller,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black54,
                                        blurRadius: 10,
                                        spreadRadius: 8)
                                  ]),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    )).paddingOnly(right: 20),
                // Container(
                //   decoration: BoxDecoration(
                //       shape: BoxShape.circle, color: Colors.black38),
                //   child: GestureDetector(
                //     onTap: () {
                //       if (_isFav) {
                //         _controller.forward();
                //       } else {
                //         _controller.reverse();
                //       }
                //       setState(() {
                //         _isFav = !_isFav;
                //       });
                //     },
                //     child: LottieBuilder.asset(
                //       'assets/animations/favorite.json',
                //       height: 90,
                //       fit: BoxFit.cover,
                //       controller: _controller,
                //     ),
                //   ).paddingAll(15),
                // ),
                Container(
                    height: screenSize.height * 0.15,
                    width: screenSize.width * 0.9,
                    decoration: const BoxDecoration(
                        color: Color(0x73000000),
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20),
                            top: Radius.circular(20))),
                    child: SizedBox(
                      width: screenSize.width * 0.8,
                      height: screenSize.height * 0.1,
                      child: Text(
                        widget.articles.title ?? 'Temp',
                        style: AppTheme.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ).paddingOnly(left: 15, top: 10, right: 10)),
              ],
            ),
          )
        ],
      ).paddingOnly(bottom: 30),
    );
  }
}
