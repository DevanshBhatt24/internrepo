import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technical_ind/screens/radar/radarHome.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StockScreener extends StatefulWidget {
  StockScreener({Key key}) : super(key: key);

  @override
  _StockScreenerState createState() => _StockScreenerState();
}

class _StockScreenerState extends State<StockScreener> {
  WebViewController controllerGlobal;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    setOpenedStockScreener();
  }

  setOpenedStockScreener() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('openedStockScreener', true);
  }

  Future<bool> _handleBack(context) async {
    var status = await controllerGlobal.canGoBack();
    if (status) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      // Navigator.of(context).pop();
      // Navigator.of(context).pop();
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => RadarHome()));
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // Navigator.of(context).pop();
        return _handleBack(context);
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(5, 50, 5, 10),
          child: Stack(
            children: [
              WebView(
                initialUrl: 'about:blank',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  controllerGlobal = webViewController;
                  _loadHtmlFromAssets();
                },
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              if (isLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/stockScreener.html');
    controllerGlobal.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
