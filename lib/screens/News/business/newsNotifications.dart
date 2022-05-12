import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/screens/News/newsDetails.dart';
import 'package:workmanager/workmanager.dart';
import 'model.dart';
import 'newsServices.dart';
import 'package:technical_ind/main.dart';
import 'package:timezone/timezone.dart' as tz;

class NewsNotifications {
  final BuildContext context;
  NewsNotifications({this.context});

  isLaunchedByNotification() async {
    final notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      await _onSelectNotification(notificationAppLaunchDetails.payload);
    }
  }

  Future<FlutterLocalNotificationsPlugin> initNotification() async {
    FlutterLocalNotificationsPlugin flip =
        new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('icon_trans_bg');

    var settings = new InitializationSettings(android: android);
    await flip.initialize(settings,
        onSelectNotification: _onSelectNotification);
    return flip;
  }

  Future<void> _onSelectNotification(String payload) async {
    // Article article = await NewsServices.getLatestArticle("Markets");
    // String imageUrl = await NewsServices.getImageUrl(article.link);
    print("on_select_notification run");
    FullArticle fullArticle = await NewsServices.getFullArticle(payload);
    Article article =
        new Article(link: fullArticle.link, title: fullArticle.title);
    String imageUrl = await NewsServices.getImageUrl(article.link);
    print("News notification tapped : " + payload);

    // Navigator.pop(context);
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

  showNotificationNow() async {
    var flip = await initNotification();
    Article article = await NewsServices.getLatestArticle("Markets");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      "channel.id",
      "channel.name",
      "channel.description",
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(article.title),
    );

    // initialise channel platform for both Android and iOS device.
    var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    
    await flip.show(
      0,
      "Market News",
      article.title,
      platformChannelSpecifics,
      payload: article.link,
    );
  }

  showNotificationDaily(id, time) async {
    FlutterLocalNotificationsPlugin flip = await initNotification();
    Article article = await NewsServices.getLatestArticle("Markets");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      "channel.id",
      "channel.name",
      "channel.description",
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(article.title),
    );

    // initialise channel platform for both Android and iOS device.
    var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flip.showDailyAtTime(
        id, "Market News", article.title, time, platformChannelSpecifics);
  }
}
