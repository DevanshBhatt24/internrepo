import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';

//import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles.dart';

class RowItem extends StatelessWidget {
  final String title, value;
  final double fontsize;
  final double pad;
  final Color color;
  const RowItem(this.title, this.value,
      {Key key, this.fontsize, this.pad = 6, this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: pad),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Text(title, style: bodyText2White60),
          if (value.toLowerCase().contains("stars"))
            value[0] != "-"
                ? RatingBar.readOnly(
                    initialRating:
                        value != "-" ? double.parse(value.split(" ")[0]) : 0.0,
                    isHalfAllowed: true,
                    halfFilledIcon: Icons.star_half,
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    filledColor: almostWhite,
                    emptyColor: almostWhite,
                    size: 15,
                  )
                : Expanded(
                    child: new Text(value[0],
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        style: bodyText2White),
                  ),
          if (!value.toLowerCase().contains("stars"))
            Expanded(
              child: new Text(value,
                  // overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: bodyText2White),
            )
        ],
      ),
    );
  }
}
