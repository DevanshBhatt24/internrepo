import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:technical_ind/initicon_custom.dart';
import 'package:technical_ind/screens/rss_feeds/models/feed_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../styles.dart';

class RssCard extends StatefulWidget {
  FeedModel feed;
  RssCard({Key key, this.feed}) : super(key: key);

  @override
  State<RssCard> createState() => _RssCardState();
}

class _RssCardState extends State<RssCard> {
  @override
  Widget build(BuildContext context) {
    bool isError = false;
    //yt section
    String videoId;
    YoutubePlayerController _controller;
    if (widget.feed.link.contains('youtube')) {
      videoId = YoutubePlayer.convertUrlToId(widget.feed.link);
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    }

    //logo section
    String logo = '';
    if (widget.feed.link.toLowerCase().contains('instagram')) {
      logo = 'assets/icons/instagram3.svg';
    } else if (widget.feed.link.toLowerCase().contains('youtube')) {
      logo = 'assets/icons/youtube2.svg';
    } else if (widget.feed.link.toLowerCase().contains('twitter')) {
      logo = 'assets/icons/twitter2.svg';
    }

    print('logo $logo');

    //time section
    DateTime d =
        DateTime.fromMillisecondsSinceEpoch(widget.feed.timeStamp * 1000);
    DateTime current = DateTime.now();
    String timediff;
    if (current.difference(d).inDays > 0) {
      if (current.difference(d).inDays == 1) {
        timediff = '${current.difference(d).inDays.toString()} day ago';
      } else {
        timediff = '${current.difference(d).inDays.toString()} days ago';
      }
    } else if (current.difference(d).inHours > 0) {
      if (current.difference(d).inHours == 1) {
        timediff = '${current.difference(d).inHours.toString()} hour ago';
      } else {
        timediff = '${current.difference(d).inHours.toString()} hours ago';
      }
    } else {
      if (current.difference(d).inMinutes == 1) {
        timediff = '${current.difference(d).inMinutes.toString()} minute ago';
      } else {
        timediff = '${current.difference(d).inMinutes.toString()} minutes ago';
      }
    }

    try {
      return !isError
          ? Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Card(
                elevation: 0,
                shadowColor: Colors.white70,
                color: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Row(
                        children: [
                          // Stack(
                          //   alignment: Alignment.center,
                          //   children: [
                          //     Container(
                          //       width: 49,
                          //       height: 49,
                          //       decoration: BoxDecoration(
                          //           border: Border.all(
                          //               color: Colors.pink, width: 2),
                          //           borderRadius: BorderRadius.circular(150)),
                          //     ),
                          //     Initicon(
                          //       // borderColor: Colors.green,
                          //       text: widget.feed.sourcePage[0] == '_'
                          //           ? 'm'
                          //           : widget.feed.sourcePage,
                          //       backgroundColor: Colors.white,
                          //       color: Colors.black,
                          //     )
                          //   ],
                          // ),
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 4),
                                child: Text(
                                  toBeginningOfSentenceCase(
                                      widget.feed.sourcePage),
                                  style: subtitle18,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 8),
                            child: InkWell(
                              onTap: () async {
                                if (!await launch(widget.feed.link))
                                  throw 'Could not launch ${widget.feed.link}';
                              },
                              child: SvgPicture.asset(
                                logo,
                                height: 28,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    widget.feed.link.toLowerCase().contains('twitter')
                        ? Container(
                            margin: EdgeInsets.fromLTRB(5, 5, 0, 5),
                            child: Text(widget.feed.title.split(':')[1]))
                        : Container(),
                    GestureDetector(
                      onTap: () async {
                        if (!await launch(widget.feed.link))
                          throw 'Could not launch ${widget.feed.link}';
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: !widget.feed.link.contains('youtube')
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: InkWell(
                                  onTap: widget.feed.link.contains('twitter')
                                      ? () async {
                                          if (!widget.feed.article_url
                                              .contains('twitter.com')) {
                                            if (!await launch(
                                                widget.feed.article_url))
                                              throw 'Could not launch url';
                                          }
                                        }
                                      : null,
                                  child: CachedNetworkImage(
                                      imageUrl: widget.feed.displayImage,
                                      errorWidget: (context, url, error) {
                                        setState(() {
                                          isError = true;
                                        });
                                        return Container();
                                      }),
                                ))
                            : YoutubePlayer(
                                aspectRatio: 9 / 16,
                                controller: _controller,
                                showVideoProgressIndicator: true,
                                progressIndicatorColor: Colors.amber,
                                progressColors: ProgressBarColors(
                                  playedColor: Colors.amber,
                                  handleColor: Colors.amberAccent,
                                ),
                              ),
                      ),
                    ),
                    // time diff
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
                      child: Text(
                        timediff,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container();
    } on Exception catch (_) {
      return Text('exception raised');
    }
  }
}
