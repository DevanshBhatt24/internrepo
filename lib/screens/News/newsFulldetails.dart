import 'package:flutter/material.dart';
import 'package:time_formatter/time_formatter.dart';
import '../../styles.dart';
import '../../widgets/appbar_with_bookmark_and_share.dart';
import 'business/model.dart';

class NewsFullArticle extends StatefulWidget {
  final Article article;
  final String imageUrl;
  final String fullText;
  const NewsFullArticle({Key key, this.article, this.imageUrl, this.fullText})
      : super(key: key);

  @override
  _NewsFullArticleState createState() => _NewsFullArticleState();
}

class _NewsFullArticleState extends State<NewsFullArticle> {
  @override
  Widget build(BuildContext context) {
    // DateTime time = DateTime.parse(article.publishedAt);
    return Scaffold(
      appBar: AppbarWithShare(
        text: 'News',
        showShare: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: 100,),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  color: grey,
                  child: Image.network(
                    widget.imageUrl,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ));
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  // Text(
                  //     widget.article.title
                  //         // .substring(widget.article.title.lastIndexOf('-') + 1),
                  //     ,style: captionWhite),
                  // Text(formatTime(widget.article.timestamp * 1000),
                  // style: captionWhite)
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              SizedBox(height: 16),
              Text(
                widget.article.title
                // .substring(0, widget.article.title.lastIndexOf('-') - 1),
                ,
                style: subtitle18,
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 12),

              Text(widget.fullText ?? '-',
                  style: bodyText1white.copyWith(color: white60)),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
