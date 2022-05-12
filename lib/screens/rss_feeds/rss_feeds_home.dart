import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/screens/News/business/dynamicLinkHandle.dart';
import 'package:technical_ind/screens/News/business/model.dart';
import 'package:technical_ind/screens/News/business/newsNotifications.dart';
import 'package:technical_ind/screens/News/business/newsServices.dart';
import 'package:technical_ind/screens/News/newsDetails.dart';
import 'package:technical_ind/screens/rss_feeds/models/feed_model.dart';
import 'package:technical_ind/screens/rss_feeds/rss_card.dart';
import 'package:technical_ind/screens/rss_feeds/services/rss_api_calls.dart';
import 'package:technical_ind/styles.dart';

BuildContext contextg;
typedef BackgroundMessageHandler = Future<void> Function(RemoteMessage message);

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  if (message.notification != null) {
    print(message.data["url"]);
  }
  print("backgorund message recieved");
  // NewsNotifications().isLaunchedByNotification();
  // NewsNotifications().showNotificationNow();

  return;
}

class RssFeedHome extends StatefulWidget {
  const RssFeedHome({Key key}) : super(key: key);

  @override
  State<RssFeedHome> createState() => _RssFeedHomeState();
}

class _RssFeedHomeState extends State<RssFeedHome> with WidgetsBindingObserver {
  AppLifecycleState _notification;
  RSSApiCalls _apiCalls = RSSApiCalls();
  ScrollController listScrollController = ScrollController();
  List<FeedModel> feed;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUpdatedData();
    WidgetsBinding.instance.addObserver(this);
    _apiCalls.updateCachedFeed();
    contextg = context;
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {
        // FullArticle farticle =
        //     await NewsServices.getFullArticle(message.data["url"]);
        String imageUrl = await NewsServices.getImageUrl(message.data["url"]);
        FullArticle fullArticle =
            await NewsServices.getFullArticle(message.data["url"]);
        Article article =
            Article(link: message.data["url"], title: fullArticle.title);
        pushNewScreen(
          context,
          screen: NewsDetails(
            article: article,
            imageUrl: imageUrl,
          ),
          withNavBar: false,
        );
      }
    });
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      if (message != null) {
        // Article article = await NewsServices.getLatestArticle("MARKETS");
        String imageUrl = await NewsServices.getImageUrl(message.data["url"]);
        Article article = Article(link: message.data["url"]);
        // String imageUrl = await NewsServices.getImageUrl(article.link);
        pushNewScreen(
          context,
          screen:
              // Container(child:Text(article.link)),
              NewsDetails(
            article: article,
            imageUrl: imageUrl,
          ),
          withNavBar: false,
        );
      }
    });
    FirebaseMessaging.onMessage.listen((message) async {
      if (message != null) {
        NewsNotifications(context: context).showNotificationNow();
      }
    });

    NewsDynamicLinks.handleDynamicLinkforNews(context);
    getToken();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  jumptoTop() {
    if (listScrollController.hasClients) {
      final position = listScrollController.position.minScrollExtent;
      listScrollController.jumpTo(position);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        _apiCalls.updateCachedFeed();
        getUpdatedData();

        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        _apiCalls.updateCachedFeed();
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        _apiCalls.updateCachedFeed();
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  Future<void> getUpdatedData() async {
    List<FeedModel> temp = await _apiCalls.getFeed();
    setState(() {
      feed = temp;
      isLoading = false;
    });
  }

  void getToken() async {
    print(await FirebaseMessaging.instance.getToken());
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Pitstop');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Learn",
            style: headingStyle,
          ),
        ),
        body: !isLoading
            ? RefreshIndicator(
                color: Colors.white,
                onRefresh: getUpdatedData,
                child: ListView.builder(
                    controller: listScrollController,
                    itemCount: feed.length,
                    itemBuilder: (context, index) {
                      if (index < feed.length) {
                        return RssCard(
                          feed: feed[index],
                        );
                      } else {
                        return Container();
                      }
                    }),
              )
            : LoadingPage());
  }
}
