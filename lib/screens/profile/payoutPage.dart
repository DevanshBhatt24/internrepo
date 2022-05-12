import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:share/share.dart';
import 'package:technical_ind/widgets/appbar_with_back_and_search.dart';

import '../../styles.dart';

class PayoutPage extends StatefulWidget {
  @override
  _PayoutPageState createState() => _PayoutPageState();
}

class _PayoutPageState extends State<PayoutPage> {
  var _formkey = GlobalKey<FormState>();

  var _ACcontroller = TextEditingController();
  var _IFSCcontroller = TextEditingController();

  Map<String, dynamic> fireStoreUser;
  bool enable = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(text: "Invite Friends"),
      body: Consumer(
          child: LoadingPage(),
          builder: (context, watch, child) {
            fireStoreUser = watch(firestoreUserProvider);
            _ACcontroller.text =
                fireStoreUser['refferalAccount']['accountNumber'];
            _IFSCcontroller.text = fireStoreUser['refferalAccount']['ifsc'];
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 23, right: 23, top: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 113,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF121212),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/rupee.svg",
                                height: 17.5,
                                width: 13,
                                color: Color.fromRGBO(4, 223, 84, 1),
                              ),
                              SizedBox(width: 7),
                              Text(
                                '${fireStoreUser['totalCommision']}',
                                style: GoogleFonts.ibmPlexSans(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
                                    // letterSpacing: 0.1,
                                    color: Color.fromRGBO(4, 223, 84, 1)),
                              ),
                            ],
                          ),
                          SizedBox(height: 7),
                          Text(
                            "Total commision earned",
                            style: GoogleFonts.ibmPlexSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFFFFFF)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 29),
                    Text(
                      "Payout details",
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    SizedBox(height: 12),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _ACcontroller,
                            readOnly: !enable,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if (enable) {
                                    if (_ACcontroller.text !=
                                        fireStoreUser['refferalAccount']
                                            ['accountNumber']) _updateUpi();
                                  } else {
                                    setState(() {
                                      enable = true;
                                      //  focusNode.requestFocus();
                                    });
                                  }
                                },
                                icon: enable
                                    ? Icon(
                                        Icons.check,
                                        color: Color.fromRGBO(4, 223, 84, 1),
                                      )
                                    : FaIcon(
                                        FontAwesomeIcons.pen,
                                        size: 15,
                                        color: white,
                                      ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              labelText: "ACCOUNT NUMBER",
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Account number is required';
                              }

                              // if (!RegExp(r"^[\w.-]+@[\w.-]+$").hasMatch(value)) {
                              //   return 'Please enter a valid UPI ID';
                              // }
                              return null;
                            },
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.25,
                              color: white,
                            ),
                            onFieldSubmitted: (val) {
                              if (!_formkey.currentState.validate()) {
                                return;
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _IFSCcontroller,
                            readOnly: !enable,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if (enable) {
                                    if (_ACcontroller.text !=
                                        fireStoreUser['refferalAccount']
                                            ['ifsc']) _updateUpi();
                                  } else {
                                    setState(() {
                                      enable = true;
                                      //  focusNode.requestFocus();
                                    });
                                  }
                                },
                                icon: enable
                                    ? Icon(
                                        Icons.check,
                                        color: Color.fromRGBO(4, 223, 84, 1),
                                      )
                                    : FaIcon(
                                        FontAwesomeIcons.pen,
                                        size: 15,
                                        color: white,
                                      ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              labelText: "IFSC",
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'IFSC is required';
                              }

                              // if (!RegExp(r"^[\w.-]+@[\w.-]+$").hasMatch(value)) {
                              //   return 'Please enter a valid UPI ID';
                              // }
                              return null;
                            },
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.25,
                              color: white,
                            ),
                            onFieldSubmitted: (val) {
                              if (!_formkey.currentState.validate()) {
                                return;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 21),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 79),
                    //   child: Text(
                    //     "Enter your upi id to receive comission directly into your bank account.",
                    //     style: GoogleFonts.ibmPlexSans(
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.w400,
                    //       color: white,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 20),

                    enable
                        ? Center(
                            child: TextButton(
                              onPressed: enable
                                  ? () {
                                      // Share.share(
                                      //     'Join Bottomstreet ${fireStoreUser['dynamicLink']}');
                                      if (enable) {
                                        _updateUpi();
                                        BotToast.showText(
                                            contentColor: almostWhite,
                                            textStyle: TextStyle(color: black),
                                            text: "Saved");
                                      }
                                    }
                                  : null,
                              child: Container(
                                height: 42,
                                width: 193,
                                decoration: BoxDecoration(
                                  color: blue,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    'Save',
                                    style: GoogleFonts.ibmPlexSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.1,
                                        color: white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: 20),
                    Text(
                      "Your referral link",
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      height: 65,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff121212),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 11.0, top: 12, right: 28, bottom: 12),
                              child: Text(
                                "${fireStoreUser['dynamicLink']}",
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Share.share(
                                    'Join Bottomstreet ${fireStoreUser['dynamicLink']}');
                              },
                              child: Text('Share'))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 27,
                    ),
                    Text(
                      "Refer your friends and family and earn 10% bonus whenever they recharge !",
                      style: heading1profile,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Text(
                        "Earn 10% bonus whenever your referrals recharge for a monthly or yearly plan . Receive comission directly in your bank account.",
                        style: subtitle1profile,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // SizedBox(height: 58),
                    // Center(
                    //   child: TextButton(
                    //     onPressed: () {
                    //       Share.share(
                    //           'Join Bottomstreet ${fireStoreUser['dynamicLink']}');
                    //     },
                    //     child: Container(
                    //       height: 42,
                    //       width: 193,
                    //       decoration: BoxDecoration(
                    //         color: Color(0xFF007AFF),
                    //         borderRadius: BorderRadius.circular(5),
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           'Share',
                    //           style: GoogleFonts.ibmPlexSans(
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w500,
                    //               letterSpacing: 0.1,
                    //               color: Color(0xFFFFF6F6)),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            );
          }),
    );
  }

  _updateUpi() async {
    if (!_formkey.currentState.validate()) return;
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: Container(
          height: 50,
          width: 50,
          child: Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      ),
    );
    _formkey.currentState.save();
    var db = context.read(storageServicesProvider);
    await db.updateUpi(_ACcontroller.text, _IFSCcontroller.text);
    setState(() {
      enable = false;
    });
    Navigator.of(context).pop();
  }
}
