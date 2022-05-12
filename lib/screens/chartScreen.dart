import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:technical_ind/screens/indices/business/indices_global_model.dart';
import 'package:technical_ind/styles.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class ChartScreen extends StatefulWidget {
  final bool isCommodity, isEtf;
  final bool isIndice;
  final String companyName;
  final bool isCrypto;
  final bool isUsingWeb, presentInSymbols;
  final String showToastMsg, etfTicker;

  final String isin;
  final bool isForex;
  const ChartScreen(
      {Key key,
      this.isin,
      this.etfTicker,
      this.isEtf,
      this.isCrypto = false,
      this.isForex = false,
      this.isIndice = false,
      this.isCommodity = false,
      this.companyName,
      this.isUsingWeb = false,
      this.showToastMsg,
      this.presentInSymbols = true})
      : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  String html = '';

  // @override
  // void initState() {
  //   super.initState();
  //   // Enable hybrid composition.
  //   if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  // }

  String url = '';
  bool isLoading = true;
  WebViewController _controller;
  getSymbol() async {
    ChartsSymbol c;

    if (widget.isCrypto) {
      http.Response response = await http.get(Uri.parse(
          'https://api.bottomstreet.com/api/data?page=ticker_symbols&filter_name=identifier&filter_value=${widget.companyName}'));
      var decode = jsonDecode(response.body);
      print(decode);
      String ticker = decode["ticker_symbol"]?.replaceAll(" ", "") ?? "null";
      print("Ticker : $ticker");

      url = 'https://in.tradingview.com/chart/?symbol=${ticker}&theme=dark';
    } else if (widget.isUsingWeb == false) {
      if (widget.isCrypto != true && widget.isIndice != true) {
        String js =
            await rootBundle.loadString('assets/instrument/tickerSymbol.json');
        final chartsSymbol = chartsSymbolFromJson(js);

        c = chartsSymbol.firstWhere((element) =>
            element.name.toLowerCase() == widget.companyName.toLowerCase());
      }
      if (widget.isin == null) {
        if (widget.presentInSymbols && widget.isCommodity == false) {
          String js = await rootBundle
              .loadString('assets/instrument/tickerSymbol.json');
          final chartsSymbol = chartsSymbolFromJson(js);
          if (widget.companyName.contains("derived")) {
            print(widget.companyName + " this is before");
            c = chartsSymbol.firstWhere((element) =>
                element.name.toLowerCase() ==
                widget.companyName.toLowerCase().replaceAll('derived', ''));
            // print(widget.companyName+" this is before");
          } else {
            c = chartsSymbol.firstWhere((element) =>
                element.name.toLowerCase() == widget.companyName.toLowerCase());
          }
          // if (c.tickerSymbol.toString().contains("USD")) {
          //   BotToast.showText(
          //       contentColor: blue,
          //       text:
          //           "Prices are shown in USD as INR prices are not available currently.");
          // }
        } else {
          c = ChartsSymbol(tickerSymbol: widget.companyName);
        }
      }
    } else {
      if (widget.isin != null) {
        await http
            .get(Uri.parse(
                'https://api.bottomstreet.com/api/data?page=ticker_symbols&filter_name=identifier&filter_value=${widget.isin}'))
            .then((value) {
          var tickerSymbol = json.decode(value.body);

          String ticker =
              tickerSymbol["ticker_symbol"]?.replaceAll(" ", "") ?? "null";
          print("Ticker : $ticker");

          url = 'https://in.tradingview.com/chart/?symbol=${ticker}&theme=dark';
        });
        if (url.contains("null")) {
          String js = await rootBundle
              .loadString('assets/instrument/tickerSymbol.json');
          final chartsSymbol = chartsSymbolFromJson(js);
          final companyName =
              widget.companyName.toLowerCase().replaceAll(" ", "");
          c = chartsSymbol.firstWhere((element) =>
              element.name
                  .toLowerCase()
                  .replaceAll("&", "and")
                  .replaceAll(" ", "")
                  .trim()
                  .contains(companyName) ||
              companyName.contains(element.name
                  .toLowerCase()
                  .trim()
                  .replaceAll("&", "and")
                  .replaceAll(" ", "")) ||
              element.name
                  .toLowerCase()
                  .replaceAll("&", "and")
                  .replaceAll(" ", "")
                  .trim()
                  .contains(companyName.replaceAll("ltd.", "limited")) ||
              companyName.replaceAll("ltd.", "limited").contains(element.name
                  .toLowerCase()
                  .trim()
                  .replaceAll("&", "and")
                  .replaceAll(" ", "")));

          if (c != null)
            url =
                'https://in.tradingview.com/chart/?symbol=${c.tickerSymbol.replaceAll(" ", "")}&theme=dark';
        }
      } else if (widget.isIndice == true) {
        await http
            .get(Uri.parse(
                'https://api.bottomstreet.com/api/data?page=ticker_symbols&filter_name=identifier&filter_value=${widget.companyName.replaceAll("&", "and").replaceAll(" Index", "")}'))
            .then((value) {
          var tickerSymbol = json.decode(value.body);

          url =
              'https://in.tradingview.com/chart/?symbol=${tickerSymbol["ticker_symbol"]}&theme=dark';
        });
        if (url.contains("null")) {
          ChartsSymbol c;
          String js = await rootBundle
              .loadString('assets/instrument/tickerSymbol.json');
          final chartsSymbol = chartsSymbolFromJson(js);
          c = chartsSymbol.firstWhere((element) =>
              element.name
                  .toLowerCase()
                  .contains(widget.companyName.toLowerCase()) ||
              widget.companyName
                  .toLowerCase()
                  .contains(element.name.toLowerCase()));
          url =
              'https://in.tradingview.com/chart/?symbol=${c?.tickerSymbol}&theme=dark';
        }
      } else if (widget.isCommodity == true) {
        url = 'https://www.mcxindia.com/en/Advance-Chart/GOLD/04JUN2021';
      } else if (widget.isForex == true) {
        String ticker = widget.companyName.replaceAll('/', '');
        await http
            .get(Uri.parse(
                "https://api.bottomstreet.com/api/data?page=ticker_symbols&filter_name=identifier&filter_value=${ticker}"))
            .then((value) {
          c = ChartsSymbol(
              tickerSymbol: json.decode(value.body)["ticker_symbol"]);
        });
      } else if (widget.isEtf) {
        url =
            "https://in.tradingview.com/chart/?symbol=${widget.etfTicker}&theme=dark";
      }
    }

    if (widget.isUsingWeb == false) {
      html = '''<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>*</title>
	<style>
		*{
			margin: 0;
			padding: 0;
			box-sizing: border-box;
		}
		body{
			height: 100vh;
			width: 100vw;
		}

	</style>
</head>
<body>
<!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div id="tradingview_7ce9d"></div>

  <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
  <script type="text/javascript">
  new TradingView.widget(
  {
  "height":"100%",
  "width" : "100%",
  "symbol":''' +
          '"${c?.tickerSymbol}"' +
          ''',
  "interval": "D",
  "timezone": "Etc/UTC",
  "theme": "dark",
  "style": "2",
  "locale": "in",
  "toolbar_bg": "#000000",
  "enable_publishing": false,
  "hide_legend": true,
  "withdateranges": true,
  "hide_side_toolbar": false,
  "allow_symbol_change": true,
  "save_image": false,
  "container_id": "tradingview_7ce9d"
}
  );
  </script>
</div>
<!-- TradingView Widget END -->
<!-- TradingView Widget END -->
</body>
</html>''';
    }

    print("get url: $url");
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    getSymbol();
    // setState(() {});

    if (widget.showToastMsg != null) {
      BotToast.showText(contentColor: blue, text: widget.showToastMsg);
    }
  }

  // final flutterWebviewPlugin = new FlutterWebviewPlugin();

  WebViewController webViewController;
  @override
  Widget build(BuildContext context) {
    // getSymbol();
    print("@#${widget.isUsingWeb}");

    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (BuildContext context) {
          return Container(
            color: black,
            padding: EdgeInsets.all(0),
            child: Stack(
              children: [
                isLoading
                    ? Positioned.fill(
                        child: Container(
                        color: Colors.black,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                      ))
                    : widget.isUsingWeb == true
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: WebView(
                              initialUrl: url,
                              javascriptMode: JavascriptMode.unrestricted,
                              onWebViewCreated:
                                  (WebViewController webViewController) {
                                _controller = webViewController;
                              },
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: WebView(
                              initialUrl: 'about:blank',
                              javascriptMode: JavascriptMode.unrestricted,
                              onWebViewCreated:
                                  (WebViewController webViewController) {
                                _controller = webViewController;
                                _controller.loadUrl(Uri.dataFromString(html,
                                        mimeType: 'text/html',
                                        encoding: Encoding.getByName('utf-8'))
                                    .toString());
                              },
                            ),
                          ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void onlyshowChart() {}
}
// To parse this JSON data, do
//
//     final chartsSymbol = chartsSymbolFromJson(jsonString);

List<ChartsSymbol> chartsSymbolFromJson(String str) => List<ChartsSymbol>.from(
    json.decode(str).map((x) => ChartsSymbol.fromJson(x)));
List<String> sectorserviceFromJson(String str) =>
    List<String>.from(json.decode(str).map((x) => x['value'].toString()));
String chartsSymbolToJson(List<ChartsSymbol> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChartsSymbol {
  ChartsSymbol({
    this.tickerSymbol,
    this.name,
  });

  dynamic tickerSymbol;
  String name;

  factory ChartsSymbol.fromJson(Map<String, dynamic> json) => ChartsSymbol(
        tickerSymbol: json["TICKER_SYMBOL"],
        name: json["NAME"],
      );

  Map<String, dynamic> toJson() => {
        "TICKER_SYMBOL": tickerSymbol,
        "NAME": name,
      };
}

class Chartwidget extends StatelessWidget {
  final bool isUsingWeb;
  final String url;
  const Chartwidget({this.isUsingWeb, this.url, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WebViewController _controller;
    return isUsingWeb == true
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
              },
            ),
          )
        : Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WebView(
              initialUrl: 'about:blank',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
                // _controller.loadUrl(Uri.dataFromString(html,
                //         mimeType: 'text/html',
                //         encoding: Encoding.getByName('utf-8'))
                //     .toString());
              },
            ),
          );
  }
}
