import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';
import '../styles.dart';
import '../widgets/item.dart';

class CardGridItem extends StatelessWidget {
  final List<RowItem> items;
  final Widget subtitle;
  final String title, value, subvalue;
  final Color color;
  final bool isGlobal;

  CardGridItem(
      {Key key,
      this.isGlobal = false,
      this.items = const <RowItem>[],
      this.subtitle,
      this.title,
      this.value,
      this.subvalue,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 190,
      // height: 188,
      //margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: darkGrey,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 8,
            color: Color(0xff000000).withOpacity(0.04),
          )
        ],
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
          ),
          SizedBox(height: 2),
          subtitle ?? Container(),
          SizedBox(height: 10),
          Text(value, textAlign: TextAlign.center, style: bodyText2White),
          SizedBox(height: 2),
          Text(subvalue,
              textAlign: TextAlign.center,
              style: bodyText2AnyColour.copyWith(color: color)),
          if (!isGlobal) SizedBox(height: 13),
          ...items
        ],
      ),
    );
  }
}
