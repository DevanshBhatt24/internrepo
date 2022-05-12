import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:technical_ind/providers/authproviders.dart';
import 'package:technical_ind/screens/News/category_specific_news.dart';
import 'package:technical_ind/screens/News/business/dynamicLinkHandle.dart';

class DynamicLinksApi {
  final dynamicLink = FirebaseDynamicLinks.instance;
  final User user = FirebaseAuth.instance.currentUser;
  Future<void> handleDynamicLink(context) async {
    print("Searching dynamic link...");
    try {
      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
        print("dynamiclinkData: XXXXXXXXXXXXXXXXXXXX");
        print(dynamicLinkData.link);
        await handleSuccessLinking(dynamicLinkData);
      }, onError: (OnLinkErrorException e) async {
        print('onLinkError');
        print(e.message);
      });
    } catch (e) {
      print(e);
    }

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    print("deeplink: ");
    print(deepLink);
    await handleSuccessLinking(data);
  }

  Future<String> createReferralLink(
      // String referralCode
      ) async {
    final String referralCode = user.uid;
    final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
      uriPrefix: 'https://app.bottomstreet.com',
      link: Uri.parse('https://app.bottomstreet.com/refer?code=$referralCode'),
      androidParameters: AndroidParameters(
        packageName: 'com.paprclip.bottomstreet',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Refer A Friend',
        description: 'Refer and earn',
      ),
    );

    final ShortDynamicLink shortLink =
        await dynamicLinkParameters.buildShortLink();

    final Uri dynamicUrl = shortLink.shortUrl;
    print(dynamicUrl);
    return dynamicUrl.toString();
  }

  Future handleSuccessLinking(PendingDynamicLinkData data) async {
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      var isRefer = deepLink.pathSegments.contains('refer');
      if (isRefer) {
        var code = deepLink.queryParameters['code'];
        print(deepLink.queryParameters['code']);

        if (code != null) {
          
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('refferalID', code);
          FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .update({"refferedBy": code});
        }
      }
    }
  }
}
