import 'dart:convert';
import 'dart:math';

import 'package:date_calc/date_calc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:technical_ind/refferal/referModel.dart';
import 'package:technical_ind/screens/profile/account/paytm_response_model.dart';
import 'package:technical_ind/screens/profile/feedback.dart';
import 'package:technical_ind/storage/storageServices.dart';
import 'package:http/http.dart' as http;

import '../../../providers/authproviders.dart';
import '../../../providers/storageProviders.dart';
import '../../../styles.dart';
import '../../../widgets/appbar_with_back_and_search.dart';
import 'planActive.dart';

class Subscription extends StatefulWidget {
  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  List<bool> flag = [false, false, false];

  // Razorpay _razorpay;

  String mid = "LIMVzj32258451764640";
  // String mid = "RmBJpm28255827175294";

  String customerid;
  String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890@-_.';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  var u;
  var phone;
  var email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(text: 'Plans', height: 40),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text('Features',
                  style: TextStyle(fontSize: 16, color: almostWhite)),
              SizedBox(height: 10),
              _row('Unlimited Watchlist', 'assets/icons/bookmark-line (1).svg'),
              _row('End-to-End Encryption', 'assets/icons/lock-line.svg'),
              _row('Real-time Data', 'assets/icons/time-line.svg'),
              _row('Transparent Data Policy',
                  'assets/startIcons/data-policy logo.svg'),
              _row('Live News', 'assets/icons/vidicon-line.svg'),
              _row('No Ads', 'assets/icons/tv_off-24px.svg'),
              _row('Zero 3rd Party Access',
                  'assets/startIcons/No-access-3rd-party.svg'),
              _row('Complete Financial Coverage',
                  'assets/icons/database-2-line.svg'),
              SizedBox(height: 20),
              Center(
                child: Text('Choose your Plan',
                    style: TextStyle(fontSize: 21, color: almostWhite)),
              ),
              SizedBox(height: 10),
              Center(
                child: Text('Prepaid Plans',
                    style: TextStyle(fontSize: 12, color: white60)),
              ),
              SizedBox(height: 20),
              Container(
                // height: 88,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(child: button('₹ 299/Month', 0, 130.0)),
                        SizedBox(width: 20),
                        Flexible(child: button('₹ 2999/Year', 1, 130.0)),
                        // SizedBox(width: 10),
                        // button('₹ 12999/3 Year', 1)
                      ],
                    ),
                    SizedBox(height: 20),
                    // button('₹ 12999/3 Years', 2, 180.0),
                  ],
                ),
              ),
              SizedBox(height: 20),
              (flag[0] || flag[1] || flag[2])
                  ? Center(
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0)),
                          height: 48,
                          minWidth: MediaQuery.of(context).size.width,
                          color: blue,
                          onPressed: () {
                            openCheckout();
                          },
                          child: Text('Recharge',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: almostWhite,
                                  fontWeight: FontWeight.w500))),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget button(String txt, int index, double width) {
    return FlatButton(
      onPressed: () {
        setState(() {
          for (int i = 0; i < 3; i++) flag[i] = false;
          flag[index] = true;
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      color: flag[index] ? almostWhite : darkGrey,
      child: Container(
        width: width,
        height: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Icon(Icons.check_circle,
                size: 16, color: flag[index] ? Colors.black : white38),
            Center(
              child: RichText(
                  text: TextSpan(
                      text: txt.split('/')[0],
                      style: TextStyle(
                          color: flag[index] ? Colors.black : white38,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      children: [
                    TextSpan(
                      text: "/" + txt.split('/')[1],
                      style: TextStyle(
                          color: flag[index] ? Colors.black : white38,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ])),
            ),
            Center(
              child: Text(
                '(GST Inclusive)',
                style: TextStyle(
                    color: flag[index] ? Colors.black : white38, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    // _razorpay = Razorpay();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    u = context.read(authServicesProvider).currentUser;

    customerid = user.uid;
  }

  void openCheckout() async {
    // var options = {
    //   'key': 'rzp_test_HyWA7WUqKlW6Yf',
    //   'amount': flag[0] ? 50000 : 500000,
    //   'name': 'BottomStreet',
    //   'description': flag[0] ? 'Monthly subcription' : 'Yearly subcription',
    //   'prefill': {'contact': phone, 'email': email},
    // };
    PaytmResponse paytmResponse;
    String orderId = getRandomString(50);
    String callbackUrl =
        "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=$orderId";

    String prodCallbackUrl =
        " https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=$orderId";

    String checksumUrl =
        "http://3.108.91.77/api/create_checksum?orderId=$orderId";
    String amount = flag[0]
        ? "299.00"
        : flag[1]
            ? "2999.00"
            : "12999.00";

    try {
      var response = await http.get(Uri.parse(checksumUrl));
      String chksm = response.body;
      var bytes = utf8.encode(chksm);
      var base64Str = base64.encode(bytes);
      print(response.body);
      String validateChecksumUrl =
          "http://3.108.91.77/api/validate_checksum?orderId=$orderId&paytmChecksum=${base64Str}";

      var validate = await http.get(Uri.parse(validateChecksumUrl));
      print(validate.body);

      String check = validate.body.replaceAll("\"", "");

      if (check.contains("Checksum Matched")) {
        String initiateTxn =
            "http://3.108.91.77/api/initiate_txn?&orderId=$orderId&amountInINR=$amount&customerId=$customerid";

        var txn = await http.get(Uri.parse(initiateTxn));

        print(txn.body);

        var jsonTxn = json.decode(txn.body);
        // print(jsonTxn["body"]["txnToken"]);
        var result;

        if (jsonTxn["body"]["resultInfo"]["resultStatus"] == "S") {
          var responseInitiateTransaction = AllInOneSdk.startTransaction(
              mid,
              orderId,
              amount,
              jsonTxn["body"]["txnToken"],
              prodCallbackUrl,
              false,
              false);

          responseInitiateTransaction.then((value) async {
            print(value);
            setState(() {
              result = value.toString();
            });
            String checkTxn =
                "http://3.108.91.77/api/check_txn?orderId=$orderId";
            var checkTXN = await http.get(Uri.parse(checkTxn));
            print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 1");
            paytmResponse = PaytmResponse.fromJson(json.decode(checkTXN.body));
            if (paytmResponse.body.resultInfo.resultStatus == "TXN_SUCCESS") {
              _handlePaymentSuccess(paytmResponse);
            } else {
              _handlePaymentError(paytmResponse);
            }

            print(checkTXN.body);
            print(paytmResponse);
          }).catchError((onError) async {
            print(
                "??????????????????????????????????????????????????????????????????????????????? 1");
            if (onError is PlatformException) {
              setState(() {
                result = onError.message + " \n  " + onError.details.toString();
              });
              // print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 2");
            } else {
              setState(() {
                result = onError.toString();
              });
              // print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 3");
            }
            String checkTxn =
                "http://3.108.91.77/api/check_txn?orderId=$orderId";
            var checkTXN = await http.get(Uri.parse(checkTxn));
            paytmResponse = PaytmResponse.fromJson(json.decode(checkTXN.body));
            print(paytmResponse);
            print(checkTXN.body);
            print(callbackUrl);
            print(result);
            if (paytmResponse.body.resultInfo.resultStatus == "TXN_SUCCESS") {
              _handlePaymentSuccess(paytmResponse);
            } else {
              _handlePaymentError(paytmResponse);
            }
          });
        }
      } else {
        print("????");
        print(prodCallbackUrl);
      }
      // _razorpay.open(options);
      // var response = AllInOneSdk.startTransaction(
      //     mid, orderId, "500.00", txntoken, callbackUrl, true, true);
      // response.then((value) {
      //   print(value);
      //   setState(() {
      //     result = value.toString();
      //   });
      // }).catchError((onError) {
      //   if (onError is PlatformException) {
      //     setState(() {
      //       result = onError.message + " \n  " + onError.details.toString();
      //     });
      //   } else {
      //     setState(() {
      //       result = onError.toString();
      //     });
      //   }
      // });
    } catch (e) {
      debugPrint(e);
    }
  }

  // void _handleExternalWallet(PaytmResponse response) {
  //   BotToast.showText(
  //       contentColor: almostWhite,
  //       textStyle: TextStyle(color: black),
  //       text: "EXTERNAL_WALLET: " + response.walletName);
  // }

  void _handlePaymentError(PaytmResponse response) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: Material(
          color: Colors.transparent,
          child: Container(
            height: 100,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 50,
                          width: 50,
                          child: SvgPicture.asset(
                            "assets/icons/failed.svg",
                          )),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Payment Failed",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close)),
                )
              ],
            ),
          ),
        ),
      ),
    );
    // BotToast.showText(contentColor: blue,backgroundColor: Colors.white,contentColor: Colors.black,
    //     text: "ERROR: " + response.code.toString() + " - " + response.message);
  }

  void _handlePaymentSuccess(PaytmResponse response) async {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Processing your payment..."),
        content: Container(
          height: 50,
          width: 50,
          child: Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      ),
    );
    var u = context.read(firestoreUserProvider);
    bool alreadySub = u['status'].toString() == 'onSub';
    DateCalc d = DateCalc.fromDateTime(u['trialEnded'] == false
        ? DateTime.now()
        : DateTime.parse(u['EndDate']));
    DateTime d2 = flag[0]
        ? d.addMonth(1)
        : flag[1]
            ? d.addYear(1)
            : d.addYear(3);

    List<String> p = List.castFrom(u['payments']);
    p.add(response.body.txnId);

    print(p);
    await context.read(storageServicesProvider).updateUser({
      'EndDate': d2.toIso8601String(),
      'status': 'onSub',
      'payments': p.toList(),
      'trialEnded': true
    });

    if (u['refferedBy'].toString() != "direct") {
      var refUID = u['refferedBy'].toString();
      double amount = flag[0]
          ? 50.00
          : flag[1]
              ? 500.00
              : 1300.00;
      ReferAccount acc = await StorageService.getRefferAccount(refUID);
      await StorageService.handleUpiPayment(
          acc, amount.toStringAsFixed(2), refUID);
    }
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PlanActive(
                  user: context.read(firestoreUserProvider),
                  planTime: flag[0]
                      ? "Monthly"
                      : flag[1]
                          ? 'Yearly'
                          : '3 Years',
                  isSub: alreadySub,
                )));
  }

  Widget _row(String s, String icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SvgPicture.asset(icon, color: almostWhite),
          SizedBox(width: 10),
          Text(s, style: TextStyle(fontSize: 14, color: almostWhite)),
        ],
      ),
    );
  }
}
