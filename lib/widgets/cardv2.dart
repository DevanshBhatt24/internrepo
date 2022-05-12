import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles.dart';
import 'item.dart';

class StockCardv2 extends StatelessWidget {
  final String title, subtitle, price, highlight;
  final Color color;

  const StockCardv2(
      {Key key,
      this.title,
      this.price,
      this.highlight,
      this.color,
      this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 183.h,
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: darkGrey,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: almostWhite,
            ),
          ),
          new Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.sp,
              color: white60,
            ),
          ),
          SizedBox(height: 4.h),
          new Text(
            price,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: almostWhite,
            ),
          ),
          SizedBox(height: 4.h),
          new Container(
            height: 22.00,
            width: 118.00,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.00),
            ),
            child: Center(
              child: new Text(
                highlight,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: darkGrey,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          RowItem(
            "Bid Qty",
            "3211.2",
            fontsize: 12.sp,
          ),
        ],
      ),
    );
  }
}
