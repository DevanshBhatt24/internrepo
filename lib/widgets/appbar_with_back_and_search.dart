import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class AppBarWithBack extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final double height;
  final bool haveSearch;

  const AppBarWithBack({this.text, this.height = 55, this.haveSearch = false})
      : super();

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      actions: [
        haveSearch ? Icon(Icons.search_rounded) : Container(),
        SizedBox(
          width: 10,
        ),
      ],
      title: Text(text, style: headline5White),
    );
  }
}
