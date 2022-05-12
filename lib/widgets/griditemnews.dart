import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:technical_ind/screens/News/business/model.dart';
import 'package:technical_ind/screens/News/business/newsServices.dart';
import 'package:technical_ind/screens/News/newsDetails.dart';
import 'package:time_formatter/time_formatter.dart';

import '../styles.dart';

class GridItem extends StatefulWidget {
  final Article article;
  final bool show;

  const GridItem({Key key, this.article, this.show}) : super(key: key);

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem>
    with AutomaticKeepAliveClientMixin {
  String imageUrl;
  FullArticle fullArticle;
  String outlineArticle;
  getFullArticle() async {
    fullArticle =
        await NewsServices.getFullArticle(widget.article.link).whenComplete(() {
      setState(() {});
    });
  }

  String ans;
  bool _loading = true;
  // getFullArticle2() async {
  //   outlineArticle = await NewsServices.getoutlineApi(widget.article.link);
  //   print(ans);
  //   print(widget.article.link);
  //   setState(() {
  //     ans = _parseHtmlString(outlineArticle);
  //     _loading = false;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    getFullArticle();
    getimage();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(
      widget.article.timestamp * 1000,
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          if (imageUrl != null) {
            pushNewScreen(
              context,
              screen: NewsDetails(
                article: widget.article,
                imageUrl: imageUrl,
              ),
              // screen: OutlineApiView(
              //   url: widget.article.link,
              // ),
            );
          }
        },
        child: new Container(
          child: Stack(
            children: [
              Container(color: Color(0xff121212)),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.1, 0.9],
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.20)
                      ],
                    ),
                  ),
                ),
              ),
              widget.show
                  ? Positioned.fill(
                      child:
                          // imageUrl == null
                          //     ? SizedBox(
                          //         height: 200,
                          //         child: Shimmer.fromColors(
                          //           baseColor: Colors.grey,
                          //           highlightColor: Colors.white,
                          //           child: Stack(
                          //             fit: StackFit.expand,
                          //             children: [
                          //               Icon(Icons.image, size: 40),
                          //               ClipRRect(
                          //                 // Clip it cleanly.
                          //                 child: BackdropFilter(
                          //                   filter: ImageFilter.blur(
                          //                       sigmaX: 2, sigmaY: 2),
                          //                   child: Container(
                          //                     color:
                          //                         Colors.grey[100].withOpacity(0.1),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       )
                          //     :
                          _imageLoader(imageUrl),
                    )
                  : Positioned(
                      left: 0.546 * MediaQuery.of(context).size.width,
                      right: 6,
                      top: 4,
                      bottom: 4,
                      child:
                          //  imageUrl == null
                          //     ? SizedBox(
                          //         height: 200,
                          //         child: Shimmer.fromColors(
                          //           baseColor: Colors.grey,
                          //           highlightColor: Colors.white,
                          //           child: Stack(
                          //             fit: StackFit.expand,
                          //             children: [
                          //               Icon(Icons.image, size: 40),
                          //               ClipRRect(
                          //                 // Clip it cleanly.
                          //                 child: BackdropFilter(
                          //                   filter: ImageFilter.blur(
                          //                       sigmaX: 2, sigmaY: 2),
                          //                   child: Container(
                          //                     color:
                          //                         Colors.grey[100].withOpacity(0.1),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       )
                          //     :
                          Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: _imageLoader(imageUrl),
                        ),
                      ),
                    ),
              Positioned(
                left: 0.052 * MediaQuery.of(context).size.width,
                bottom: 12,
                child: new Text(
                  formatTime(time.millisecondsSinceEpoch),
                  style: overlineWhite60,
                ),
              ),
              widget.show
                  ? Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black38, Colors.transparent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      // child: _imageLoader(imageUrl),
                    )
                  : SizedBox.shrink(),
              widget.show
                  ? Positioned(
                      left: 21,
                      bottom: 114,
                      right: 71,
                      top: 20,
                      child: Container(
                        child: Text(
                          widget.article.title.substring(
                            0,
                            widget.article.title.lastIndexOf('-') - 1,
                          ),
                          // overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.ibmPlexSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.1,
                              color: almostWhite),
                        ),
                      ),
                    )
                  : Positioned(
                      left: 0.052 * MediaQuery.of(context).size.width,
                      bottom: 10,
                      right: 0.377 * MediaQuery.of(context).size.width,
                      top: 16,
                      child: Container(
                        child: new Text(
                          widget.article.title.substring(
                            0,
                            widget.article.title.lastIndexOf('-') - 1,
                          ),
                          style: GoogleFonts.ibmPlexSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.1,
                            color: almostWhite,
                          ),
                        ),
                      ),
                    ),
              !widget.show
                  ? Positioned(
                      left: 247,
                      right: 0,
                      top: 4,
                      bottom: 4,
                      child: Container(
                        decoration: BoxDecoration(
                            // color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  CachedNetworkImage _imageLoader(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => new SizedBox(
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
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    color: Colors.grey[100].withOpacity(0.1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      errorWidget: (context, url, error) => new Stack(
        fit: StackFit.expand,
        children: [
          Icon(Icons.hide_image, size: 40),
          ClipRRect(
            // Clip it cleanly.
            child: Container(
              color: Colors.grey[100].withOpacity(0.1),
            ),
          ),
        ],
      ),
      // loadingBuilder: (BuildContext context, Widget child,
      //     ImageChunkEvent loadingProgress) {
      //   if (loadingProgress == null) return child;
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
      //               filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      //               child: Container(
      //                 color: Colors.grey[100].withOpacity(0.1),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   );
      // },
      fit: BoxFit.cover,
      // errorBuilder: (context, error, stackTrace) {
      //   return Stack(
      //     fit: StackFit.expand,
      //     children: [
      //       Icon(Icons.hide_image, size: 40),
      //       ClipRRect(
      //         // Clip it cleanly.
      //         child: Container(
      //           color: Colors.grey[100].withOpacity(0.1),
      //         ),
      //       ),
      //     ],
      //   );
      // },
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;
    return parsedString;
  }

  getimage() async {
    imageUrl =
        await NewsServices.getImageUrl(widget.article.link).whenComplete(() {
      if (this.mounted) {
        setState(() {});
      }
    });
  }
}
