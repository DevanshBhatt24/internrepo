import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../styles.dart';
import 'register.dart';
import 'signIn.dart';

class Startscreen extends StatefulWidget {
  Startscreen({Key key}) : super(key: key);

  @override
  _StartscreenState createState() => _StartscreenState();
}

class _StartscreenState extends State<Startscreen> {
  showRefferal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    showRefferal();
  }

  Widget _row(String s, String icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SvgPicture.asset(icon, color: almostWhite),
          SizedBox(width: 10),
          Text(s, style: TextStyle(fontSize: 14, color: almostWhite)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              right: 0, top: 0, child: Image.asset("assets/images/bg.png")),
          Positioned(
              left: 16,
              bottom: 368,
              child: Text("Financial\nMarkets\nIn Your Pocket.",
                  style: headline4White)),
          // Positioned(
          //     left: 16,
          //     bottom: 314,
          //     child: Text(
          //       "Try free for 30 days, no strings attached.",
          //       style: subtitle1White.copyWith(fontSize: 18),
          //     )),
          // Positioned(
          //   left: 12,
          //   bottom: 250.0,
          //   child: TextButton(
          //     onPressed: () {
          //       showDialog(
          //           context: context,
          //           builder: (context) {
          //             return AlertDialog(
          //               backgroundColor: darkGrey,
          //               shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(12)),
          //               contentPadding:
          //                   EdgeInsets.symmetric(vertical: 28, horizontal: 20),
          //               // title: Text(
          //               //   "Prepaid Plans",
          //               //   style: subtitle18.copyWith(fontSize: 20),
          //               //   textAlign: TextAlign.center,
          //               // ),
          //               content: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   SizedBox(height: 10),
          //                   Center(
          //                     child: Text('Features',
          //                         style: TextStyle(
          //                             fontSize: 20, color: almostWhite)),
          //                   ),
          //                   SizedBox(height: 10),
          //                   _row('Unlimited Watchlist',
          //                       'assets/icons/bookmark-line (1).svg'),
          //                   _row('End-to-End Encryption',
          //                       'assets/icons/lock-line.svg'),
          //                   _row(
          //                       'Real-time Data', 'assets/icons/time-line.svg'),
          //                   _row('Transparent Data Policy',
          //                       'assets/startIcons/data-policy logo.svg'),
          //                   _row('Live News', 'assets/icons/vidicon-line.svg'),
          //                   _row('No Ads', 'assets/icons/tv_off-24px.svg'),
          //                   _row('Zero 3rd Party Access',
          //                       'assets/startIcons/No-access-3rd-party.svg'),
          //                   _row('Complete Financial Coverage',
          //                       'assets/icons/database-2-line.svg'),
          //                   SizedBox(height: 15),
          //                   Divider(
          //                     height: 6,
          //                     color: almostWhite,
          //                   ),
          //                   SizedBox(height: 15),
          //                   Center(
          //                     child: Text('Prepaid Plans',
          //                         style: TextStyle(
          //                             fontSize: 20, color: almostWhite)),
          //                   ),
          //                   SizedBox(height: 20),
          //                   Container(
          //                     // height: 88,
          //                     child: Column(
          //                       children: [
          //                         Row(
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           children: [
          //                             Flexible(
          //                                 child: Container(
          //                                     padding: EdgeInsets.all(10),
          //                                     decoration: BoxDecoration(
          //                                         borderRadius:
          //                                             BorderRadius.circular(
          //                                                 5.0),
          //                                         border: Border.all(
          //                                             color: almostWhite)),
          //                                     child: Text('₹ 299/Month'))),

          //                             SizedBox(width: 20),
          //                             Flexible(
          //                                 child: Container(
          //                                     padding: EdgeInsets.all(10),
          //                                     decoration: BoxDecoration(
          //                                         borderRadius:
          //                                             BorderRadius.circular(
          //                                                 5.0),
          //                                         border: Border.all(
          //                                             color: almostWhite)),
          //                                     child: Text('₹ 2999/Year'))),
          //                             // SizedBox(width: 10),
          //                             // button('₹ 12999/3 Year', 1)
          //                           ],
          //                         ),
          //                         SizedBox(height: 20),
          //                         // Container(
          //                         //     padding: EdgeInsets.all(10),
          //                         //     decoration: BoxDecoration(
          //                         //         borderRadius:
          //                         //             BorderRadius.circular(5.0),
          //                         //         border:
          //                         //             Border.all(color: almostWhite)),
          //                         //     child: Text('₹ 12999/3 Year'))
          //                       ],
          //                     ),
          //                   ),
          //                   SizedBox(height: 20),
          //                   Spacer(),
          //                   Center(
          //                     child: FlatButton(
          //                         shape: RoundedRectangleBorder(
          //                             borderRadius: BorderRadius.circular(6.0)),
          //                         height: 48,
          //                         minWidth: MediaQuery.of(context).size.width,
          //                         color: blue,
          //                         onPressed: () {
          //                           Navigator.pop(context);
          //                         },
          //                         child: Text('Close',
          //                             style: TextStyle(
          //                                 fontSize: 14,
          //                                 color: almostWhite,
          //                                 fontWeight: FontWeight.w500))),
          //                   )
          //                 ],
          //               ),
          //             );
          //           });
          //     },
          //     child: Text("View Plans"),
          //   ),
          // ),
          Positioned(
              left: 16,
              right: 16,
              bottom: 98,
              child: Container(
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(6)),
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: almostWhite,
                            borderRadius: BorderRadius.circular(6)),
                        child: Center(
                          child: Text(
                            "Register",
                            style: button.copyWith(color: darkGrey),
                          ),
                        ),
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignInPage()));
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            "Sign In",
                            style: buttonWhite,
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
