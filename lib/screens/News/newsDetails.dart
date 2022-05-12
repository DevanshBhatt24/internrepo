import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/News/business/dynamicLinkHandle.dart';
import 'package:time_formatter/time_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../styles.dart';
import '../../widgets/appbar_with_bookmark_and_share.dart';
// import 'business/dynamicLinkHandle.dart';
import 'business/model.dart';
import 'business/newsServices.dart';

class NewsDetails extends StatefulWidget {
  final Article article;
  final String imageUrl;
  final bool canPop;
  final canAddtoWatchlist;

  const NewsDetails(
      {Key key,
      this.canAddtoWatchlist = true,
       this.article, this.imageUrl = null, this.canPop = true})
      : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  FullArticle fullArticle;
  Article article;
  List<String> paragraph;
  bool isSaved = false;
  Future<bool> checkIsSaved() async {
    print("checking saved...");
    var user = context.read(firestoreUserProvider);
    if (user.containsKey('NewsWatchlist')) {
      List<Article> articles =
          List.from(user['NewsWatchlist'].map((e) => Article.fromJson(e)));

      return articles.indexWhere((element) => element.link == article.link) !=
          -1;
    }
    return false;
  }

  String link;

  // _getDeepLinkNews() async {
  //   link = await NewsDynamicLinks().createNewsLink(widget.article.title);
  // }

  @override
  Widget build(BuildContext context) {
    // DateTime time = DateTime.parse(article.publishedAt);
    return (link == null && fullArticle == null)
        ? LoadingPage()
        : Scaffold(
            body: Column(
              children: [
                AppbarWithShare(
                  showBookmark: widget.canAddtoWatchlist,
                  showBack: widget.canPop,
                  // text: widget.article.title + '\n' + link ?? '-',
                  onShare: () async {
                    var dynamicUrl =
                        await NewsDynamicLinks.createNewsLink(article.link);

                    Share.share(
                      dynamicUrl,
                      subject: "BottomStreet-News",
                    );
                    return;
                  },
                  showShare: true,
                  isSaved: checkIsSaved,
                  onSaved: () async {
                    print("saving...");
                    var db = context.read(storageServicesProvider);
                    await db.updateNewsWatchlist(article);
                    BotToast.showText(
                        contentColor: almostWhite,
                        textStyle: TextStyle(color: black),
                        text: "Added to Watchlist");
                  },
                  delSaved: () async {
                    print("removing...");
                    var db = context.read(storageServicesProvider);
                    await db.removeNewsWatchlist(article);
                    BotToast.showText(
                        contentColor: almostWhite,
                        textStyle: TextStyle(color: black),
                        text: "Removed from Watchlist");
                  },
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: widget.imageUrl == null
                              ? CircularProgressIndicator()
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Container(
                                    height: 180,
                                    width: MediaQuery.of(context).size.width,
                                    // color: grey,
                                    child: CachedNetworkImage(
                                      imageUrl: widget.imageUrl,
                                      // loadingBuilder: (BuildContext context,
                                      //     Widget child,
                                      //     ImageChunkEvent loadingProgress) {
                                      //   if (loadingProgress == null)
                                      //     return child;
                                      //   return SizedBox(
                                      //     height: 200,
                                      //     child: Shimmer.fromColors(
                                      //       baseColor: Colors.grey,
                                      //       highlightColor: Colors.white,
                                      //       child: Stack(
                                      //         fit: StackFit.expand,
                                      //         children: [
                                      //           Icon(Icons.image, size: 40),
                                      //           ClipRRect(
                                      //             // Clip it cleanly.
                                      //             child: BackdropFilter(
                                      //               filter: ImageFilter.blur(
                                      //                   sigmaX: 2, sigmaY: 2),
                                      //               child: Container(
                                      //                 color: Colors.grey[100]
                                      //                     .withOpacity(0.1),
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   );
                                      // },
                                      placeholder: (context, url) =>
                                          new SizedBox(
                                        height: 200,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey,
                                          highlightColor: Colors.white,
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Icon(Icons.image, size: 40),
                                              ClipRRect(
                                                // Clip it cleanly.
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                      sigmaX: 2, sigmaY: 2),
                                                  child: Container(
                                                    color: Colors.grey[100]
                                                        .withOpacity(0.1),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      fit: BoxFit.cover,
                                      // errorBuilder:
                                      //     (context, error, stackTrace) {
                                      //   return Stack(
                                      //     fit: StackFit.expand,
                                      //     children: [
                                      //       Icon(Icons.hide_image, size: 40),
                                      //       ClipRRect(
                                      //         // Clip it cleanly.
                                      //         child: Container(
                                      //           color: Colors.grey[100]
                                      //               .withOpacity(0.1),
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   );
                                      // },
                                      errorWidget: (context, url, error) =>
                                          new Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Icon(Icons.hide_image, size: 40),
                                          ClipRRect(
                                            // Clip it cleanly.
                                            child: Container(
                                              color: Colors.grey[100]
                                                  .withOpacity(0.1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              // Text(
                              // article.title
                              // .substring(
                              //     article.title.lastIndexOf('-') + 1),
                              // ,style: captionWhite),
                              // Text(formatTime(article.timestamp * 1000),
                              //     style: captionWhite)
                              //
                            ],
                            
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            widget.article.title,
                            // ,
                            style: subtitle18,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        fullArticle?.fullText == null
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: Center(
                                  child: Text(
                                    "No articles available.",
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (_, i) => Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Text(
                                        fullArticle?.fullText[i],
                                        style: bodyText1white.copyWith(
                                            color: white60),
                                      )),
                                  itemCount: fullArticle.fullText?.length ?? 0,
                                ),
                              ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          );
  }

  getFullArticle() async {
    fullArticle =
        await NewsServices.getFullArticle(widget.article.link).whenComplete(() {
      setState(() {});
    });
    // if (fullArticle != null) print(fullArticle.fullText[1] + "jkjfl dlkfj ");
    // if (fullArticle != null) {
    //   // print(paragraph[1]);
    //   setState(() {
    //     paragraph = fullArticle.fullText.split("\",\"");
    //     print(fullArticle.fullText);
    //   });
    // }
  }

  @override
  void initState() {
    super.initState();
    InAppReview.instance.requestReview();
    article = widget.article;
    getFullArticle();
    // _inAppReview();
    // _getDeepLinkNews();
  }
}


