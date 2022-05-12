import 'package:flutter/material.dart';
import '../styles.dart';

class AppBarWithCross extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final double height;
  final bool haveSearch;

  const AppBarWithCross({this.text, this.height = 55, this.haveSearch = false})
      : super();

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      
      backgroundColor: Colors.black,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Icon(
            Icons.close_rounded,
            color: almostWhite,
            size: 24,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      title: Text(text, style: headline5.copyWith(color: almostWhite)),
    );
  }
}
