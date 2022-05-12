import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/providers/authproviders.dart';
import 'package:technical_ind/screens/News/newsDetails.dart';

import 'model.dart';
import 'newsServices.dart';

class NewsDynamicLinks {
  final dynamicLink = FirebaseDynamicLinks.instance;

  static Future<void> handleDynamicLinkforNews(BuildContext context) async {
    
    
    print("Searching dynamic link...");
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
      print("dynamiclinkData: ");
      print(dynamicLinkData.link);
      print(dynamicLinkData.link.queryParameters);
      var code = dynamicLinkData.link.queryParameters["code"];
      final user = context.read(authServicesProvider).currentUser.uid;
      if (code != null && user != code) {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(user)
            .update({"refferedBy": code});
      }
      await handleSuccessLinking(dynamicLinkData, context);
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    await handleSuccessLinking(data, context);
  }

  static Future<String> createNewsLink(String newsUrl) async {
    final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
      uriPrefix: 'https://app.bottomstreet.com',
      link: Uri.parse('https://app.bottomstreet.com/news?url=$newsUrl'),
      androidParameters: AndroidParameters(
        packageName: 'com.paprclip.bottomstreet',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'news',
      ),
    );
    final finalLink = await dynamicLinkParameters.buildShortLink();
    final Uri dynamicUrl = finalLink.shortUrl;
    print(dynamicUrl);
    return dynamicUrl.toString();
  }

  static Future handleSuccessLinking(
    PendingDynamicLinkData data,
    BuildContext context,
  ) async {
    
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      final queryParameters = deepLink.queryParameters;
      // if (queryParameters.length > 0) {
      String target = queryParameters['url'];
      if (target != null) {
        FullArticle fullArticle = await NewsServices.getFullArticle(target);
        Article article = Article(link: fullArticle.link,title: fullArticle.title ,published: "Tue, 21 Sep 2021 12:49:00 GMT", timestamp: 1632228540);
        // await NewsServices.getLatestArticle("Markets");
        String imageUrl = await NewsServices.getImageUrl(fullArticle.link);
        pushNewScreen(
      context,
      screen: NewsDetails(
        article: article,
        imageUrl: imageUrl,
      ),
      withNavBar: false,
    );
      }
      // }
    }
  }
}
