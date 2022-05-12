import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';

import '../styles.dart';

class CustomCardStock extends StatelessWidget {
  final String title, price, highlight;
  final List<Widget> list;
  final Color color;
  final Function onTap;
  final String date;

  const CustomCardStock(
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
        // height: 200,
        // width: 172,
        // margin: EdgeInsets.all(4),
        padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: darkGrey,
        ),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MarqueeText(
                  text: TextSpan(text: title),
                  speed: 10,
                  style: subtitle1White),
              (date != null)
                  ? MarqueeText(
                      text: TextSpan(text: date),
                      style: captionWhite60,
                      speed: 10,
                    )
                  : SizedBox(),
              SizedBox(height: 10),
              Text(price, textAlign: TextAlign.center, style: bodyText2),
              SizedBox(height: 2),
              Text(
                highlight,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: color,
                ),
              ),
              SizedBox(height: 12),
              ...list
            ],
          ),
        ),
      ),
    );
  }
}
