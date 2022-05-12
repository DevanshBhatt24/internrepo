import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../components/slidePanel.dart';
import '../../styles.dart';
import '../../widgets/datagrid.dart';
import '../../widgets/miss.dart';
import '../etf/business/models/etf_explore_model.dart';

class PortFolioMutual extends StatefulWidget {
  final Factsheet factsheet;
  PortFolioMutual({
    Key key,
    this.factsheet,
  }) : super(key: key);

  @override
  _PortFolioMutualState createState() => _PortFolioMutualState();
}

class _PortFolioMutualState extends State<PortFolioMutual> {
  List<String> menu = ["Trailing Return", "Rank", "SIP Return"];

  int _selected = 0;
  PanelController _panelController = new PanelController();
  List<String> years = ["2019", "2018", "2017", "2016", "2015"];
  List<String> sectors = [
    "Technology",
    "Financial",
    "Automobile",
    "FMCG",
    "Cons Durable"
  ];
  List<String> periods = [
    "1 Month",
    "3 Months",
    "6 Months",
    "1 Year",
    "3 Years",
    "5 Years"
  ];

  Factsheet factsheet;
  @override
  void initState() {
    super.initState();
    factsheet = widget.factsheet;
  }

  @override
  Widget build(BuildContext context) {
    return SlidePanel(
      menu: menu,
      defaultWidget: menu[_selected],
      panelController: _panelController,
      onChange: (val) {
        setState(() {
          _selected = val;
        });
      },
      child: Scaffold(
        // backgroundColor: kindaWhite,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // SizedBox(height: 38),
                // Text(
                //   'Parag Parikh Long Term Equity Fund\nDirect - Growth',
                //   textAlign: TextAlign.center,
                //   style: headline5White
                // ),
                SizedBox(height: 28),
                _text("Top Holdings"),
                SizedBox(height: 28),

                Container(
                  height: 28.0 * 9 + 40,
                  child: CustomTable(
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    fixedColumnWidth: 136,
                    columnwidth: 100,
                    headersTitle: [
                      "Company",
                      "EPS-TTM (₹)",
                      "1 Yr Ret (%)",
                      "Instrument",
                      "%ASSETS",
                      "P/E",
                      // "EPS-TTM (₹)"
                    ],
                    totalColumns: 6,
                    // itemCount: factsheet.topHoldings.length,
                    leftSideItemBuilder: (c, i) {
                      // return Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 6),
                      //   child: Text(factsheet.topHoldings[i].company,
                      //       style: bodyText2White),
                      // );
                      return DataTableItem(
                          // data: [factsheet.topHoldings[i].company],
                          );
                    },
                    rightSideItemBuilder: (c, i) {
                      return DataTableItem(
                        data: [
                          // factsheet.topHoldings[i].epsTtm,
                          // factsheet.topHoldings[i].oneYearReturn,
                          // factsheet.topHoldings[i].instruments,
                          // factsheet.topHoldings[i].assetPercent,
                          // factsheet.topHoldings[i].pe,
                          // factsheet.topHoldings[i].e,
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 48),
                _text("Returns (%)"),
                SizedBox(height: 24),
                buildInkWell(),
                SizedBox(height: 18),
                _selected == 0
                    ? TableBar(
                        title1: "PERIOD",
                        title2: "FUND",
                        title3: "CATEGORY",
                        isextended: true,
                      )
                    : _selected == 1
                        ? TableBar(
                            title1: "PERIOD",
                            title2: "RETURN",
                            // title3: "CATEGORY",
                            isextended: true,
                          )
                        : TableBar(
                            title1: "PERIOD",
                            title2: "CATEGORY",
                            // title3: "CATEGORY",
                            isextended: true,
                          ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  // child: Column(
                  //   children: _selected == 0
                  //       ? List.generate(
                  //           factsheet.returnData.length,
                  //           (index) => TableItem(
                  //             title: factsheet.returnData[index].date,
                  //             value: factsheet.returnData[index].trailingFund,
                  //             remarks:
                  //                 factsheet.returnData[index].trailingCategory,
                  //             isextended: true,
                  //           ),
                  //         )
                  //       : _selected == 1
                  //           ? List.generate(
                  //               factsheet.returnData.length,
                  //               (index) => TableItem(
                  //                 title: factsheet.returnData[index].date,
                  //                 value:
                  //                     factsheet.returnData[index].rankCategory,
                  //                 // remarks: factsheet
                  //                 //     .returnData[index].trailingCategory,
                  //                 isextended: true,
                  //               ),
                  //             )
                  //           : List.generate(
                  //               factsheet.returnData.length,
                  //               (index) => TableItem(
                  //                 title: factsheet.returnData[index].date,
                  //                 value: factsheet.returnData[index].sipReturn,
                  //                 // remarks: factsheet
                  //                 //     .returnData[index].trailingCategory,
                  //                 isextended: true,
                  //               ),
                  //             ),
                  // ),
                ),
                SizedBox(height: 45),
                _text("Top 5 Sectors"),
                SizedBox(height: 28),

                TableBar(
                  title1: "COMPANY",
                  title2: "%ASSETS",
                  title3: "MOM CHANGE%",
                  isextended: true,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  // child: Column(
                  //   children: List.generate(
                  //     factsheet.sectorsData.length,
                  //     (index) => TableItem(
                  //       title: factsheet.sectorsData[index].sectors,
                  //       value: factsheet.sectorsData[index].assestsPer,
                  //       remarks: factsheet.sectorsData[index].monChangesPer,
                  //       isextended: false,
                  //     ),
                  //   ),
                  // ),
                ),
                SizedBox(height: 32),
                _text("Quarterly Returns (%)"),
                SizedBox(height: 22),
                Container(
                  height: 37.0 * 9 + 40,
                  child: CustomTable(
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    fixedColumnWidth: 0.2 * MediaQuery.of(context).size.width,
                    columnwidth: 0.18 * MediaQuery.of(context).size.width,
                    headersTitle: [
                      "Year",
                      "Q1",
                      "Q2",
                      "Q3",
                      "Q4",
                    ],
                    totalColumns: 5,
                    // itemCount: factsheet.quaterlyReturns.length,
                    // leftSideItemBuilder: (c, i) {
                    //   return Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 10),
                    //     child: Text(factsheet.quaterlyReturns[i].year,
                    //         style: bodyText2White),
                    //   );
                    // },
                    // rightSideItemBuilder: (c, i) {
                    //   return DataTableItem(
                    //     data: [
                    //       factsheet.quaterlyReturns[i].q1,
                    //       factsheet.quaterlyReturns[i].q2,
                    //       factsheet.quaterlyReturns[i].q3,
                    //       factsheet.quaterlyReturns[i].q4,
                    //     ],
                    //   );
                    // },
                  ),
                ),

                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell buildInkWell() {
    return InkWell(
      onTap: () {
        _panelController.open();
      },
      child: Container(
          //width: 150.w,
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: darkGrey, borderRadius: BorderRadius.circular(6)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(menu[_selected] + '    ', style: buttonWhite),
              Icon(
                Icons.keyboard_arrow_down,
                color: almostWhite,
              )
            ],
          )),
    );
  }

  Widget _text(String t) {
    return Align(
      alignment: Alignment.center,
      child: new Text(t, style: subtitle1White),
    );
  }
}
