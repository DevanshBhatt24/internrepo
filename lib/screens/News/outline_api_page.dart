import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OutlineApiView extends StatefulWidget {
  final String url;
  OutlineApiView({this.url});
  @override
  _OutlineApiViewState createState() => _OutlineApiViewState();
}

class _OutlineApiViewState extends State<OutlineApiView> {
  final GlobalKey webViewKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: 'outline.com/${widget.url}',
        ),
      ),
    );
  }
}
