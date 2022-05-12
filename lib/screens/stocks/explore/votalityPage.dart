import 'package:flutter/material.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';

import '../../../styles.dart';
import '../../../widgets/datagrid.dart';
import '../../../widgets/miss.dart';
import '../../../widgets/tableItem.dart';

class VotalityPage extends StatefulWidget {
  final Volatility volatility;
  final String isin;
  VotalityPage({Key key, this.isin, this.volatility}) : super(key: key);

  @override
  _VotalityPageState createState() => _VotalityPageState();
}

class _VotalityPageState extends State<VotalityPage> {
  List<String> betaValues = [
    "Daily - One Month Range",
    "Daily - Three Month Range",
    "Long Term Beta",
    "Monthly - One Year Range",
    "Monthly - Two Year Range",
    "Period",
    "Weekly - One Year Range",
    "Weekly - Two Year Range",
  ];

  Volatility arr;

  bool loading = true;

  _fetchData() async {
    arr = await StockServices.getVolatility(widget.isin);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    // arr = widget.volatility;
    _fetchData();
  }

  List<String> priceRanges = [
    "3 Day",
    "5 Day",
    "10 Day",
    "15 Day",
    "30 Day",
    "50 Day",
    "5 Week",
    "10 Week",
    "20 Week",
    "50 Week",
    "3 Months",
    "6 Months",
    "9 Months",
    "12 Months",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kindaWhite,
      body: SingleChildScrollView(
          child: loading
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: LoadingPage())
              : arr.averagePriceRange.length == 0 ||
                      arr.betaValues.length == 0 ||
                      arr.sharePriceRange.length == 0
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: NoDataAvailablePage())
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (arr.betaValues.length != 0) SizedBox(height: 38),
                          if (arr.betaValues.length != 0) _text("Beta Values"),
                          if (arr.betaValues.length != 0) SizedBox(height: 26),
                          if (arr.betaValues.length != 0)
                            TableBarv2(
                              title1: "Period",
                              title2: "Beta",
                              title3: "Mean",
                              title4: "Std Deviation",
                              isextended: true,
                            ),
                          if (arr.betaValues.length != 0) SizedBox(height: 13),
                          // arr.betaValues.length != 0?
                          if (arr.betaValues.length != 0)
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Column(children:
                                  // List.generate(
                                  //   betaValues.length,
                                  //   (index) => TableItemv2(
                                  //     title: betaValues[index],
                                  //     value: arr.betaValues[0].dailyOneMonthRange,
                                  //     remarks: arr.betaValues[1].dailyOneMonthRange,
                                  //     total: arr.betaValues[2].dailyOneMonthRange,
                                  //     isextended: true,
                                  //   ),
                                  // ),
                                  [
                                TableItemv2(
                                  title: betaValues[0] ?? "",
                                  value: arr.betaValues[0].dailyOneMonthRange ??
                                      "",
                                  remarks:
                                      arr.betaValues[1].dailyOneMonthRange ??
                                          "",
                                  total: arr.betaValues[2].dailyOneMonthRange ??
                                      "",
                                  isextended: true,
                                ),
                                TableItemv2(
                                  title: betaValues[1] ?? "",
                                  value:
                                      arr.betaValues[0].dailyThreeMonthRange ??
                                          "",
                                  remarks:
                                      arr.betaValues[1].dailyThreeMonthRange ??
                                          "",
                                  total:
                                      arr.betaValues[2].dailyThreeMonthRange ??
                                          "",
                                  isextended: true,
                                ),
                                TableItemv2(
                                  title: betaValues[2] ?? "",
                                  value: arr.betaValues[0].longTermBeta ?? "",
                                  remarks: arr.betaValues[1].longTermBeta ?? "",
                                  total: arr.betaValues[2].longTermBeta ?? "",
                                  isextended: true,
                                ),
                                TableItemv2(
                                  title: betaValues[3] ?? "",
                                  value:
                                      arr.betaValues[0].monthlyOneYearRange ??
                                          "",
                                  remarks:
                                      arr.betaValues[1].monthlyOneYearRange ??
                                          "",
                                  total:
                                      arr.betaValues[2].monthlyOneYearRange ??
                                          "",
                                  isextended: true,
                                ),
                                TableItemv2(
                                  title: betaValues[4] ?? "",
                                  value:
                                      arr.betaValues[0].monthlyTwoYearRange ??
                                          "",
                                  remarks:
                                      arr.betaValues[1].monthlyTwoYearRange ??
                                          "",
                                  total:
                                      arr.betaValues[2].monthlyTwoYearRange ??
                                          "",
                                  isextended: true,
                                ),
                                // TableItemv2(
                                //   title: betaValues[5],
                                //   value: arr.betaValues[0].period,
                                //   remarks: arr.betaValues[1].period,
                                //   total: arr.betaValues[2].period,
                                //   isextended: true,
                                // ),
                                TableItemv2(
                                  title: betaValues[6] ?? "",
                                  value: arr.betaValues[0].weeklyOneYearRange ??
                                      "",
                                  remarks:
                                      arr.betaValues[1].weeklyOneYearRange ??
                                          "",
                                  total: arr.betaValues[2].weeklyOneYearRange ??
                                      "",
                                  isextended: true,
                                ),
                                TableItemv2(
                                  title: betaValues[7] ?? "",
                                  value: arr.betaValues[0].weeklyTwoYearRange ??
                                      "",
                                  remarks:
                                      arr.betaValues[1].weeklyOneYearRange ??
                                          "",
                                  total: arr.betaValues[2].weeklyOneYearRange ??
                                      "",
                                  isextended: true,
                                ),
                              ]),
                            ),
                          if (arr.betaValues.length != 0) SizedBox(height: 33),
                          if (arr.sharePriceRange.length != 0)
                            _text('Share Price Range'),
                          if (arr.sharePriceRange.length != 0)
                            SizedBox(height: 26),
                          if (arr.sharePriceRange.length != 0)
                            Container(
                              height: arr.sharePriceRange.length * 38.0,
                              child: CustomTable(
                                fixedColumnWidth: 0.25 * MediaQuery.of(context).size.width,
                                columnwidth: 0.24 * MediaQuery.of(context).size.width,
                                headersTitle: [
                                  "Date",
                                  "High",
                                  "Low",
                                  "Close",
                                  "Price Range",
                                  "Price Range%"
                                ],
                                totalColumns: 6,
                                itemCount: arr.sharePriceRange.length ?? 0,
                                leftSideItemBuilder: (c, i) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      arr.sharePriceRange[i].date ?? "",
                                      style: bodyText2White,
                                    ),
                                  );
                                },
                                rightSideItemBuilder: (c, i) {
                                  return DataTableItem(
                                    data: [
                                      arr.sharePriceRange[i].high ?? "",
                                      arr.sharePriceRange[i].low ?? "",
                                      arr.sharePriceRange[i].close ?? "",
                                      arr.sharePriceRange[i].priceRange ?? "",
                                      arr.sharePriceRange[i]
                                              .priceRangePercentage ??
                                          ""
                                    ],
                                  );
                                },
                              ),
                            ),
                          if (arr.sharePriceRange.length != 0)
                            SizedBox(height: 30),
                          if (arr.averagePriceRange.length != 0)
                            _text("Average Price Range"),
                          if (arr.averagePriceRange.length != 0)
                            SizedBox(height: 26),
                          if (arr.averagePriceRange.length != 0)
                            TableBar(
                              title1: "Period",
                              title2: "Avg Price Range",
                              title3: "Price Range %",
                              isextended: true,
                            ),
                          if (arr.averagePriceRange.length != 0)
                            SizedBox(height: 12),
                          if (arr.averagePriceRange.length != 0)
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Column(
                                children: List.generate(
                                  arr.averagePriceRange.length,
                                  (i) => TableItem(
                                    title:
                                        arr.averagePriceRange[i].period ?? "",
                                    value: arr.averagePriceRange[i]
                                            .averagePriceRange ??
                                        "",
                                    remarks: arr.averagePriceRange[i]
                                            .priceRangePercentage ??
                                        "",
                                    isextended: false,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    )),
    );
  }

  Widget _text(String t) {
    return Text(t ?? "", style: subtitle1White);
  }
}
