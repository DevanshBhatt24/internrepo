import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:technical_ind/screens/watchlist/emptyWatchlist.dart';

import '../../styles.dart';

class BondsW extends StatefulWidget {
  final String title;

  BondsW({Key key, this.title}) : super(key: key);

  @override
  _StocksWState createState() => _StocksWState();
}

class _StocksWState extends State<BondsW> {
  @override
  Widget build(BuildContext context) {
    return EmptyWatchlist(
      title: widget.title,
    );
  }
}
