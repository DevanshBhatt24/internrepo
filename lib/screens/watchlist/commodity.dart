import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:technical_ind/screens/watchlist/emptyWatchlist.dart';

import '../../styles.dart';

class CommodityW extends StatefulWidget {
  final String title;

  CommodityW({Key key, this.title}) : super(key: key);

  @override
  _StocksWState createState() => _StocksWState();
}

class _StocksWState extends State<CommodityW> {
  @override
  Widget build(BuildContext context) {
    return EmptyWatchlist(
      title: widget.title,
    );
  }
}
