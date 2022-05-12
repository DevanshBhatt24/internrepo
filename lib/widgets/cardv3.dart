import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles.dart';

class StockCardv3 extends StatelessWidget {
  final String title, subtitle, price, highlight, date;
  final List<Widget> list;
  final Color color;

  const StockCardv3(
      {Key key,
      this.title,
      this.price,
      this.highlight,
      this.color,
      this.list,
      this.subtitle,
      this.date})
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
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: almostWhite,
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
          color != null ? SizedBox(height: 4.h) : Container(),
          color != null
              ? Container(
                  width: 38.w,
                  height: 22,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      color == Color(0xffff6880) ? 'Sell' : "Buy",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: almostWhite,
                      ),
                    ),
                  ),
                )
              : Container(),
          SizedBox(height: 2.h),
          Text(
            date,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'IBM Plex Sans',
                fontSize: 10.sp,
                color: Colors.white.withOpacity(0.36)),
          ),
          SizedBox(height: 4.h),
          ...list
        ],
      ),
    );
  }
}
