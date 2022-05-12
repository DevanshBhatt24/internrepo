import 'dart:io';

import 'package:date_time_format/date_time_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:launch_review/launch_review.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:share/share.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/providers/authproviders.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/refferal/refferalApi.dart';
import 'package:technical_ind/screens/profile/account/createNewPass.dart';
import 'package:technical_ind/screens/profile/payoutPage.dart';
import 'package:technical_ind/screens/profile/referPage.dart';
import 'package:technical_ind/styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/custom_switch.dart';
import 'account/freeTrialSubscription.dart';
import 'account/logout.dart';
import 'account/resetPass.dart';
import 'account/subscription.dart';
import 'customerCare.dart';
import 'faq.dart';
import 'feedback.dart';
import 'referalpage2.dart';

enum Availability { LOADING, AVAILABLE, UNAVAILABLE }

extension on Availability {
  String stringify() => this.toString().split('.').last;
}

class HomeProfile extends StatefulWidget {
  @override
  _HomeProfileState createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeProfile> {
  Map<String, dynamic> fireStoreUser;

  List<Widget> widgets = [
    Container(),
    CustomerCare(),
    Container(),
    FeedBack(),
    Container(),
    Container(),
    // InappReviewWidget(),
    // ReferalPage2(),
  ];

  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    //I have commented this because I couldn't use Consumer Widget instead of Stateful Widget
    //Please change, the code you have written is in accountPage.dart
    //final _auth = watch(authServicesProvider);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          // leading: new Container(),
          actions: [
            IconButton(
              icon: Icon(Icons.clear, color: almostWhite),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: 15)
          ],
          title: Text('Profile', style: headline5White),
        ),
        body: Consumer(
          child: LoadingPage(),
          builder: (context, watch, child) {
            fireStoreUser = watch(firestoreUserProvider);
            return ListView(
              children: [
                Container(
                  // height: 111,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    color: darkGrey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(getUserName(), style: headline5White),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Icon(Icons.check_circle,
                          //         size: 16,
                          //         color: Color.fromRGBO(4, 223, 84, 1)),
                          //     SizedBox(width: 2),
                          //     Text(
                          //         fireStoreUser['status'] == 'onTrial'
                          //             ? "Free Trial (${DateTimeFormat.format(DateTime.parse(fireStoreUser['EndDate']), format: 'D, M j Y')})"
                          //             : DateTimeFormat.format(
                          //                 DateTime.parse(
                          //                     fireStoreUser['EndDate']),
                          //                 format: 'D, M j Y'),
                          //         style: bodyText2.copyWith(
                          //             color: Color.fromRGBO(4, 223, 84, 1))),
                          //   ],
                          // ),
                          // Text('Validity', style: captionWhite60)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // _customListTile(
                //     'Plans',
                //     Subscription(),
                //     Icon(
                //       CupertinoIcons.forward,
                //       color: white60,
                //     )),
                checkProvider()
                    ? Container()
                    : _customListTile(
                        "Change Password",
                        CreateNewPass(),
                        // ResetPass(email: getUserEmail()),
                        Icon(
                          CupertinoIcons.forward,
                          color: white60,
                        )),
                _customListTile(
                    "Customer Care",
                    widgets[1],
                    Icon(
                      CupertinoIcons.forward,
                      color: white60,
                    )),
                _customListTile2(
                  "FAQ's",
                  widgets[2],
                  Icon(
                    CupertinoIcons.forward,
                    color: Colors.transparent,
                  ),
                  'https://bottomstreet.com/faq.php',
                ),
                _customListTile(
                  "Feedback",
                  widgets[3],
                  Icon(
                    CupertinoIcons.forward,
                    color: white60,
                  ),
                ),
                _customListTile2("Privacy & Legal", widgets[4], SizedBox(),
                    'https://www.bottomstreet.com/legal.html'),
                _customListTile2("Disclaimer", widgets[5], SizedBox(),
                    'https://www.bottomstreet.com/legal.html'),
                _customListTile("Rate us", null, SizedBox()),
                // TextButton(
                //     onPressed: () async {
                //       var token = await FirebaseMessaging.instance.getToken();
                //       Share.share(token);
                //       print(await FirebaseMessaging.instance.getToken());
                //     },
                //     child: Text("Get Token")),

                // _customListTile(
                //   "Notifications",
                //   null,
                //   SizedBox(
                //     height: 32,
                //     width: 52,
                //     child: CustomSwitch(
                //         value: isSwitched,
                //         activeColor: Color.fromRGBO(4, 223, 84, 1),
                //         onChanged: toggle),
                //   ),
                // ),
                // _customListTile("Invite friends", widgets[7], SizedBox()),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () async {
                      String link =
                          await DynamicLinksApi().createReferralLink();
                      Share.share(
                        """A data driven platform enabling retail investors and traders for doing fundamental and technical research regarding financial markets in an easy manner.
$link""",
                        subject: "BottomStreet",
                      );
//                       Share.share(
//                         """Try Bottom Street! A investment info app goes deep in each investing segment and provides you with categorized tools you need to make smart investment decisions and grow your portfolio.
// Click the link below.
// https://play.google.com/store/apps/details?id=com.paprclip.bottomstreet""",
//                         subject: "BottomStreet",
//                       );
                      // if (fireStoreUser['ReferEnroll'] == false)
                      //   pushNewScreen(context, screen: widgets[6]);
                      // else
                      //   pushNewScreen(context, screen: PayoutPage());
                    },
                    child: Container(
                      width: 0.755 * MediaQuery.of(context).size.width,
                      height: 0.06 * MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: blue,
                      ),
                      child: Center(
                        child: Text(
                          "Invite friends",
                          style: subtitle1White,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Center(
                    child: InkWell(
                  onTap: () {
                    pushNewScreen(context, screen: Logout(), withNavBar: false);
                  },
                  child: Text('Logout', style: button.copyWith(color: red)),
                ))
              ],
            );
          },
        ));
  }

  bool checkProvider() {
    var user = context.read(authServicesProvider).currentUser;
    var data = user.providerData;
    UserInfo userInfo;
    for (userInfo in data) {
      if (userInfo.providerId == "google.com") return true;
    }

    return false;
  }

  String getUserName() {
    var user = context.read(authServicesProvider).currentUser;
    return user.displayName;
  }

  String getUserEmail() {
    var user = context.read(authServicesProvider).currentUser;
    return user.email;
  }

  void toggle(bool val) {
    setState(() {
      isSwitched = !isSwitched;
    });
  }

  Widget _customListTile(String title, Widget onTap, Widget trail) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      title: new Text(title, style: subtitle1White),
      trailing: trail,
      onTap: () async {
        if (onTap != null) {
          pushNewScreen(context, screen: onTap, withNavBar: false);
        } else {
          LaunchReview.launch();
        }
      },
    );
  }

  Widget _customListTile2(
      String title, Widget onTap, Widget trail, String urlTitle) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      title: new Text(title, style: subtitle1White),
      trailing: trail,
      onTap: () async {
        await launch(urlTitle);
      },
    );
  }
}

// class InappReviewWidget extends StatefulWidget {
//   const InappReviewWidget({Key key}) : super(key: key);

//   @override
//   _InappReviewWidgetState createState() => _InappReviewWidgetState();
// }

// class _InappReviewWidgetState extends State<InappReviewWidget> {
//   final InAppReview _inAppReview = InAppReview.instance;
//   String _appStoreId = '';
//   String _microsoftStoreId = '';
//   Availability _availability = Availability.LOADING;

//   void _setAppStoreId(String id) => _appStoreId = id;

//   void _setMicrosoftStoreId(String id) => _microsoftStoreId = id;

//   Future<void> _requestReview() => _inAppReview.requestReview();

//   Future<void> _openStoreListing() => _inAppReview.openStoreListing(
//         appStoreId: _appStoreId,
//         microsoftStoreId: _microsoftStoreId,
//       );

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       try {
//         final isAvailable = await _inAppReview.isAvailable();

//         setState(() {
//           _availability = isAvailable && !Platform.isAndroid
//               ? Availability.AVAILABLE
//               : Availability.UNAVAILABLE;
//         });
//       } catch (e) {
//         setState(() => _availability = Availability.UNAVAILABLE);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('InAppReview Example')),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('InAppReview status: ${_availability.stringify()}'),
//             TextField(
//               onChanged: _setAppStoreId,
//               decoration: InputDecoration(hintText: 'App Store ID'),
//             ),
//             TextField(
//               onChanged: _setMicrosoftStoreId,
//               decoration: InputDecoration(hintText: 'Microsoft Store ID'),
//             ),
//             ElevatedButton(
//               onPressed: _requestReview,
//               child: Text('Request Review'),
//             ),
//             ElevatedButton(
//               onPressed: _openStoreListing,
//               child: Text('Open Store Listing'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
