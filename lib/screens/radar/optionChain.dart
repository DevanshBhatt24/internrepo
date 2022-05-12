import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../styles.dart';

class OptionChain extends StatefulWidget {
  const OptionChain({Key key}) : super(key: key);

  @override
  _OptionChainState createState() => _OptionChainState();
}

class _OptionChainState extends State<OptionChain> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    setOpenedOpenChain();
  }

  setOpenedOpenChain()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('openedOpenChain', true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: ThemeData.dark(),
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 50, 5, 10),
          child: Stack(
            children: [
              WebView(
                initialUrl: 'https://web.sensibull.com/option-chain?expiry=2021-12-09&tradingsymbol=NIFTY',
                javascriptMode: JavascriptMode.unrestricted,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  color: Colors.black,
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Option Chain ',
                        style: TextStyle(color: Colors.blueAccent),
                        children: const <TextSpan>[
                          TextSpan(text: 'by Sensibull', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height:80,
                  color: Colors.black,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(CupertinoIcons.back, color: white60),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Text('Option Chain', style: headline5.copyWith(color: almostWhite)),
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
