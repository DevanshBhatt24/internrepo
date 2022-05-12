import 'package:flutter/material.dart';

import 'package:marquee_text/marquee_text.dart';

import '../styles.dart';

class StockCard extends StatelessWidget {
  final String title, price, highlight;
  final List<Widget> list;
  final Color color;
  final Function onTap;
  final String date;

  const StockCard(
      {Key key,
      this.title,
      this.price,
      this.highlight,
      this.color,
      this.list,
      this.onTap,
      this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        //height: 191,
        //width: 170,
        //margin: EdgeInsets.all(4),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: darkGrey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   title,
            //   textAlign: TextAlign.center,
            //   style: subtitle1White,
            //   overflow: TextOverflow.fade,
            //   softWrap: false,
            // ),
            MarqueeText(
              text: TextSpan(text: title),
              style: subtitle1White,
              speed: 10,
              // startAfter: Duration(seconds: 5),
              // numberOfRounds: 1,
              // blankSpace: MediaQuery.of(context).size.width / 2,
            ),
            (date != null) ? SizedBox(height: 2) : SizedBox(),
            (date != null) ? Text(date, style: captionWhite60) : SizedBox(),
            SizedBox(height: 10),
            new Text(price, textAlign: TextAlign.center, style: bodyText2),
            SizedBox(height: 2),
            Text(
              highlight,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: color,
              ),
            ),
            // SizedBox(height: 10),
            ...list
          ],
        ),
      ),
    );
  }
}
