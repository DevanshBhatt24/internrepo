import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../providers/authproviders.dart';
import '../../../styles.dart';
import '../../../widgets/appbar_with_back_and_search.dart';
import 'freeTrialSubscription.dart';
import 'logout.dart';
import 'resetPass.dart';

class AccountPage extends ConsumerWidget {
  final String text;

  const AccountPage({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _auth = watch(authServicesProvider);

    //final user = watch(authStateProvider);
    return Scaffold(
      appBar: AppBarWithBack(text: 'Account', height: 40),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 111,
              child: Card(
                color: darkGrey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        _auth.currentUser.displayName,
                        style: TextStyle(
                          color: almostWhite,
                          fontSize: 25,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle,
                              size: 16, color: Color.fromRGBO(4, 223, 84, 1)),
                          SizedBox(width: 2),
                          Text(text,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(4, 223, 84, 1)))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.only(right: 8, left: 5),
              title: Text(
                'Subscription',
                style: TextStyle(
                  fontSize: 16,
                  color: almostWhite,
                ),
              ),
              trailing: Icon(
                CupertinoIcons.forward,
                color: almostWhite,
              ),
              onTap: () {
                // pushNewScreen(context, screen: Subscription(), withNavBar: false);
                pushNewScreen(context, screen: FreeTrial(), withNavBar: false);
              },
            ),
            checkProvider(_auth.currentUser)
                ? Container()
                : ListTile(
                    contentPadding: EdgeInsets.only(right: 8, left: 5),
                    title: Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 16,
                        color: almostWhite,
                      ),
                    ),
                    trailing: Icon(
                      CupertinoIcons.forward,
                      color: almostWhite,
                    ),
                    onTap: () {
                      pushNewScreen(context,
                          screen: ResetPass(), withNavBar: false);
                    },
                  ),
            Expanded(child: SizedBox()),
            Center(
                child: InkWell(
              onTap: () {
                pushNewScreen(context, screen: Logout(), withNavBar: false);
              },
              child: Text(
                'Logout',
                style: TextStyle(
                    color: Colors.red[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ))
          ],
        ),
      ),
    );
  }

  bool checkProvider(User user) {
    var data = user.providerData;
    UserInfo userInfo;
    for (userInfo in data) {
      if (userInfo.providerId == "google.com") return true;
    }

    return false;
  }
}
