import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../styles.dart';
import '../../widgets/cardv3.dart';
import '../../widgets/item.dart';

class IntradayPage extends StatefulWidget {
  IntradayPage({Key key}) : super(key: key);

  @override
  _WeekPageState createState() => _WeekPageState();
}

class _WeekPageState extends State<IntradayPage> {
  int _selected = 0;
  List<Widget> bulk = List.generate(
    10,
    (index) => StockCardv3(
      title: "A & M Febcon",
      subtitle: "ZALAK PURVESH PARIKH",
      price: "3,413.56",
      highlight: "+410.40 (+4.02 %)",
      date: "02 Oct, 2020",
      color: index % 3 == 1 ? Color(0xffff6880) : Color(0xff479fff),
      list: [
        RowItem(
          "Traded",
          "2.2",
          fontsize: 12.sp,
        ),
        RowItem(
          "Closed",
          "3.2",
          fontsize: 12.sp,
        ),
        RowItem(
          "Quantity",
          "70200",
          fontsize: 12.sp,
        ),
      ],
    ),
  );
  List<Widget> block = List.generate(
    10,
    (index) => StockCardv3(
      title: "A & M Febcon",
      subtitle: "ZALAK PURVESH PARIKH",
      price: "3,413.56",
      highlight: "+410.40 (+4.02 %)",
      date: "02 Oct, 2020",
      color: index % 3 == 0 ? Color(0xffff6880) : Color(0xff479fff),
      list: [
        RowItem(
          "Traded",
          "2.2",
          fontsize: 12.sp,
        ),
        RowItem(
          "Closed",
          "3.2",
          fontsize: 12.sp,
        ),
        RowItem(
          "Quantity",
          "70200",
          fontsize: 12.sp,
        ),
      ],
    ),
  );
  List<Widget> large = List.generate(
    10,
    (index) => StockCardv3(
      title: "A & M Febcon",
      subtitle: "ZALAK PURVESH PARIKH",
      price: "3,413.56",
      highlight: "+410.40 (+4.02 %)",
      date: "02 Oct, 2020",
      // color:index%4==0?  Color(0xffff6880): Color(0xff479fff),
      list: [
        RowItem(
          "Traded",
          "2.2",
          fontsize: 12.sp,
        ),
        RowItem(
          "Closed",
          "3.2",
          fontsize: 12.sp,
        ),
        RowItem(
          "Quantity",
          "70200",
          fontsize: 12.sp,
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            //color: Colors.white.withOpacity(0.87),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.search,
              //color: Colors.white.withOpacity(0.87),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
        title: Text("Intraday Deals",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              // color: almostWhite,
            )),
      ),

      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            DefaultTabController(
              length: 2,
              initialIndex: 1,
              child: TabBar(
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: almostWhite,
                ),
                unselectedLabelColor: white38,
                //indicatorSize: TabBarIndicatorSize.label,
                indicator: MaterialIndicator(
                  horizontalPadding: 30,
                  bottomLeftRadius: 8,
                  bottomRightRadius: 8,
                  color: Colors.white,
                  paintingStyle: PaintingStyle.fill,
                ),
                tabs: [
                  Tab(
                    text: "BSE",
                  ),
                  Tab(
                    text: "NSE",
                    //child: NSEtab(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              height: 40.h,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selected = 0;
                        });
                      },
                      child: new Container(
                        margin: EdgeInsets.all(4),
                        //padding: EdgeInsets.all(8),
                        decoration: _selected == 0
                            ? BoxDecoration(
                                color: Color(0xffffffff).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(6.00),
                              )
                            : BoxDecoration(
                                color: darkGrey,
                                border: Border.all(
                                  width: 1.00,
                                  color: white38,
                                ),
                                borderRadius: BorderRadius.circular(6.00),
                              ),
                        child: Center(
                          child: new Text(
                            "Bulk Deals",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: _selected == 0 ? almostWhite : white38,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selected = 1;
                        });
                      },
                      child: new Container(
                        margin: EdgeInsets.all(4),
                        //padding: EdgeInsets.all(8),
                        decoration: _selected == 1
                            ? BoxDecoration(
                                color: Color(0xffffffff).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(6.00),
                              )
                            : BoxDecoration(
                                color: darkGrey,
                                border: Border.all(
                                  width: 1.00,
                                  color: white38,
                                ),
                                borderRadius: BorderRadius.circular(6.00),
                              ),
                        child: Center(
                          child: new Text(
                            "Block Deals",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: _selected == 1 ? almostWhite : white38,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selected = 2;
                        });
                      },
                      child: new Container(
                        margin: EdgeInsets.all(4),
                        //padding: EdgeInsets.all(8),
                        decoration: _selected == 2
                            ? BoxDecoration(
                                color: Color(0xffffffff).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(6.00),
                              )
                            : BoxDecoration(
                                color: darkGrey,
                                border: Border.all(
                                  width: 1.00,
                                  color: white38,
                                ),
                                borderRadius: BorderRadius.circular(6.00),
                              ),
                        child: Center(
                          child: new Text(
                            "Large Deals",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: _selected == 2 ? almostWhite : white38,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              height: 445.h,
              child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 0.87,
                  children: _selected == 0
                      ? bulk
                      : _selected == 1
                          ? block
                          : large),
            )
          ],
        ),
      )),
    );
  }
}
