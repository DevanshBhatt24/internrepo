import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../styles.dart';
import '../../../widgets/miss.dart';
import '../../../widgets/tableItem.dart';

class AnalysisPage extends StatefulWidget {
  AnalysisPage({Key key}) : super(key: key);

  @override
  _AnalysisPageState createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
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
                  "Revenue Estimate",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: almostWhite,
                  ),
                ),
              ),
              SizedBox(height: 22.h),
              TableBar(
                title1: "",
                title2: "Current qtr\n(Dec 2018)",
                title3: "Next qtr\n(Mar 2019)",
                title4: "Current yr\n(2019)",
                isextended: true,
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Column(
                  children: [
                    TableItem(
                      title: "No. of\nanalysts",
                      value: "2",
                      remarks: "2",
                      total: "2",
                      isextended: true,
                    ),
                    TableItem(
                      title: "Avg\nestimate",
                      value: "73.69 B",
                      remarks: "73.69 B",
                      total: "73.69 B",
                      isextended: true,
                    ),
                    TableItem(
                      title: "Low \nestimate",
                      value: "73.69 B",
                      remarks: "73.69 B",
                      total: "73.69 B",
                      isextended: true,
                    ),
                    TableItem(
                      title: "High \nestimate",
                      value: "73.69 B",
                      remarks: "73.69 B",
                      total: "73.69 B",
                      isextended: true,
                    ),
                    TableItem(
                      title: "Year ago \nsales",
                      value: "73.69 B",
                      remarks: "73.69 B",
                      total: "73.69 B",
                      isextended: true,
                    ),
                    TableItem(
                      title: "Sales\ngrowth",
                      value: "15.70%",
                      remarks: "15.70%",
                      total: "15.70%",
                      isextended: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Earnings History",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: almostWhite,
                  ),
                ),
              ),
              SizedBox(height: 22.h),
              TableBar(
                title1: "",
                title2: "31 Dec\n2017",
                title3: "31 Mar\n2018",
                title4: "30 Jun\n2018",
                isextended: true,
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Column(
                  children: [
                    TableItem(
                      title: "Estimate \nEPS",
                      value: "36.49",
                      remarks: "36.49",
                      total: "36.49",
                      isextended: true,
                    ),
                    TableItem(
                      title: "Actual \nEPS",
                      value: "32.9",
                      remarks: "32.9",
                      total: "32.9",
                      isextended: true,
                    ),
                    TableItem(
                      title: "Difference",
                      value: "- 3.29",
                      remarks: "- 3.29",
                      total: "- 3.29",
                      isextended: true,
                    ),
                    TableItem(
                      title: "Surprise %",
                      value: "- 9.80 %",
                      remarks: "- 9.80 %",
                      total: "- 9.80 %",
                      isextended: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "EPS Trend",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: almostWhite,
                  ),
                ),
              ),
              SizedBox(height: 22.h),
              TableBar(
                title1: "",
                title2: "Current qtr\n(Dec 2018)",
                title3: "Next qtr\n(Mar 2019)",
                title4: "Current yr\n(2019)",
                isextended: true,
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Column(
                  children: [
                    TableItem(
                      title: "Current \nestimate",
                      value: "0",
                      remarks: "0",
                      total: "0",
                      isextended: true,
                    ),
                    TableItem(
                      title: "7 days ago",
                      value: "73.6",
                      remarks: "73.69",
                      total: "73.69",
                      isextended: true,
                    ),
                    TableItem(
                      title: "30 days ago",
                      value: "73.69",
                      remarks: "73.69",
                      total: "73.69",
                      isextended: true,
                    ),
                    TableItem(
                      title: "60 days ago",
                      value: "73.69",
                      remarks: "73.69",
                      total: "73.69",
                      isextended: true,
                    ),
                    TableItem(
                      title: "90 days ago",
                      value: "73.69",
                      remarks: "73.69",
                      total: "73.69",
                      isextended: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
