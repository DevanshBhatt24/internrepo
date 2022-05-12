import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../styles.dart';
import '../../../widgets/item.dart';

class StatPage extends StatefulWidget {
  StatPage({Key key}) : super(key: key);

  @override
  _StatPageState createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kindaWhite,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 32.h),
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Valuation Measures",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: almostWhite,
                  ),
                ),
              ),
              SizedBox(height: 22.h),
              RowItem("Market cap (intra-day)", "2.63 T"),
              RowItem("Enterprise value", "2.63 T"),
              RowItem("Trailing P/E", "58.34"),
              RowItem("Forward P/E", "N/A"),
              RowItem("PEG Ratio (5 yr expected)", "N/A"),
              RowItem("Price/sales (ttm)", "14.97"),
              RowItem("Price/book (mrq)", "7.62"),
              RowItem("Enterprise value/revenue", "7.62"),
              RowItem("Enterprise value/EBITDA", "7.62"),
              SizedBox(height: 34.h),
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Financial highlights",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: almostWhite,
                  ),
                ),
              ),
              SizedBox(height: 22.h),
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Fiscal year",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: almostWhite,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              RowItem("Fiscal year ends", "31 Mar 2020"),
              RowItem("Most-recent quarter (mrq)", "30 Sept 2020"),
              SizedBox(height: 22.h),
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Profitability",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: almostWhite,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              RowItem("Profit margin", "25.60 %"),
              RowItem("Operating margin (ttm)", "34.59 %"),
              SizedBox(height: 22.h),
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Management effectiveness",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: almostWhite,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              RowItem("Return on assets (ttm)", "2.91 %"),
              RowItem("Return on equity (ttm)", "2.91 %"),
              SizedBox(height: 22.h),
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Income statement",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: almostWhite,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              RowItem("Revenue (ttm)", "175.35 B"),
              RowItem("Revenue per share (ttm)", "293.30"),
              RowItem("Quarterly revenue growth (yoy)", "293"),
              RowItem("Gross profit (ttm)", "3.30 %"),
              RowItem("EBITDA", "175.35 B"),
              RowItem("Net income avi to common (ttm)", "N/A"),
              RowItem("Diluted EPS (ttm)", "75.35"),
              SizedBox(height: 22.h),
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Balance sheet",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: almostWhite,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              RowItem("Total cash (mrq)", "2.91 %"),
              RowItem("Total cash per share (mrq)", "175.35"),
              RowItem("Total debt (mrq)", "175.35 %"),
              RowItem("Total debt/equity (mrq)", "175.35"),
              RowItem("Current ratio (mrq)", "175.35"),
              RowItem("Book value per share (mrq)", "175.35"),
              SizedBox(height: 22.h),
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Cash flow statement",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: almostWhite,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              RowItem("Operating cash flow (ttm)", "175.35 B"),
              RowItem("Levered free cash flow (ttm)", "N/A"),
              SizedBox(height: 34.h),
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Trading Information",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: almostWhite,
                  ),
                ),
              ),
              SizedBox(height: 22.h),
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Stock price history",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: almostWhite,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              RowItem("Beta (5Y monthly)", "1.19"),
              RowItem("52-week change", "5.32 %"),
              RowItem("S&P500 52-week change", "14.83 %"),
              RowItem("52-week high", "14.83 %"),
              RowItem("52-week low", "14.83 %"),
              RowItem("50-day moving average", "1,923.40"),
              RowItem("200-day moving average", "1,923.40"),
              SizedBox(height: 22.h),
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Share statistics",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: almostWhite,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              RowItem("Avg vol (3-month)", "1.19 M"),
              RowItem("Avg vol (10-day)", "5.32 M"),
              RowItem("Shares outstanding", "603.49 M"),
              RowItem("Float", "603.49 M"),
              RowItem("% held by insiders", "23.40 %"),
              RowItem("% held by institutions", "19.40 %"),
              RowItem("Shares short", "N/A"),
              RowItem("Short ratio", "N/A"),
              RowItem("Short % of float", "N/A"),
              RowItem("Short % of shares outstanding", "N/A"),
              RowItem("Shares short (prior month)", "N/A"),
              SizedBox(height: 22.h),
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Dividends & splits",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: almostWhite,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              RowItem("Forward annual dividend rate", "16"),
              RowItem("Forward annual dividend yield", "0.65 %"),
              RowItem("Trailing annual dividend rate", "0.00"),
              RowItem("Trailing annual dividend yield", "0.65 %"),
              RowItem("5-year average dividend yield", "8.00"),
              RowItem("Payout ratio", "8.00"),
              RowItem("Dividend date", "N/A"),
              RowItem("Ex-dividend date", "N/A"),
              RowItem("Last split factor", "2:1"),
              RowItem("Last split date", "31 Dec 2016"),
              SizedBox(height: 22.h),
            ],
          ),
        ),
      ),
    );
  }
}
