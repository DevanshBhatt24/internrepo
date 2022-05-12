import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/components/slidePanel.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/widgets/miss.dart';
import 'package:technical_ind/widgets/tableItem.dart';
import '../../../styles.dart';

class Ratios extends StatefulWidget {
  final FinancialsRatios ratios;
  final String title;

  const Ratios({Key key, this.ratios, this.title}) : super(key: key);
  @override
  _RationsState createState() => _RationsState();
}

class _RationsState extends State<Ratios> {
  final List<String> head = [
    'Per Share Ratios',
    'Basic EPS(₹)',
    'Diluted EPS(₹)',
    'Book Value [Excl. Reval Reserve]/Share(₹)',
    'Dividend/Share(₹)',
    'Face Value',
    'Margin Ratios',
    'Gross Profit Margin (%)',
    'Operation Margin (%)',
    'Net Profit Margin (%)',
    'Return Ratios',
    'Return on Networth / Equity(%)',
    'ROCE (%)',
    'Return on Assets (%)',
    'Liquidity Ratios',
    'Current Ratio (X)',
    'Quick Ratio (X)',
    'Leverage Ratios',
    'Debt to Equity ()',
    'Interest Coverage Ratios(%)',
    'Turnover Ratios',
    'Asset TurnOver Ratio (%)',
    'Inventory TurnOver Ratio (%)',
    'Growth Ratios',
    '3 Yr CAGR Sales (%)',
    '3 Yr CAGR Net Profit (%)',
    'Valuation Ratios',
    'EV / EBITDA (X)',
    'P / B (X)',
    'P / E (X)',
    'P / S (X)',
  ];
  // final List<Widget> head = [
  //   heading('Per Share Ratios'),
  //   text('Basic EPS(₹)'),
  //   text('Diluted EPS(₹)'),
  //   text('Book Value [Excl. Reval Reserve]/Share(₹)'),
  //   text('Dividend/Share(₹)'),
  //   text('Face Value'),
  //   heading('Margin Ratios'),
  //   text('Gross Profit Margin (%)'),
  //   text('Operation Margin (%)'),
  //   text('Net Profit Margin (%)'),
  //   heading('Return Ratios'),
  //   text('Return on Networth / Equity(%)'),
  //   text('ROCE (%)'),
  //   text('Return on Assets (%)'),
  //   heading('Liquidity Ratios'),
  //   text('Current Ratio (X)'),
  //   text('Quick Ratio (X)'),
  //   heading('Leverage Ratios'),
  //   text('Debt to Equity ()'),
  //   text('Interest Coverage Ratios(%)'),
  //   heading('Turnover Ratios'),
  //   text('Asset TurnOver Ratio (%)'),
  //   text('Inventory TurnOver Ratio (%)'),
  //   heading('Growth Ratios'),
  //   text('3 Yr CAGR Sales (%)'),
  //   text('3 Yr CAGR Net Profit (%)'),
  //   heading('Valuation Ratios'),
  //   text('EV / EBITDA (X)'),
  //   text('P / B (X)'),
  //   text('P / E (X)'),
  //   text('P / S (X)'),
  // ];

  List<String> menu = [];
  int _s1 = 1;
  int _s2 = 0;
  int _currentLeftPanel = 0;
  int _currentRightPanel = 0;
  FinancialsRatios ratios;
  bool isRight = false;
  PanelController _panelController = PanelController();

  _openRight(List<String> newMenu, int i) {
    setState(() {
      menu = newMenu;
      _currentRightPanel = i;
      isRight = true;
    });
    _panelController.open();
  }

  _openLeft(List<String> newMenu, int i) {
    setState(() {
      menu = newMenu;
      _currentLeftPanel = i;
      isRight = false;
    });
    _panelController.open();
  }

  @override
  void initState() {
    super.initState();
    ratios = widget?.ratios;
    menu = ratios.consolidated.quarters;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SlidePanel(
        menu: menu,
        defaultWidget: isRight ? menu[_s1] : menu[_s2],
        onChange: (val) {
          setState(() {
            isRight ? _s1 = val : _s2 = val;
          });
        },
        panelController: _panelController,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(84),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(CupertinoIcons.back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  title: Text(
                    "Ratios",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 5),
                Center(
                  child: Text(widget.title,
                      textAlign: TextAlign.center, style: subtitle1White),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: 5),
              StickyHeader(
                header: Material(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TabBar(
                      labelStyle: buttonWhite,
                      unselectedLabelColor: Colors.white38,
                      //indicatorSize: TabBarIndicatorSize.label,
                      indicator: MaterialIndicator(
                        horizontalPadding: 24,
                        bottomLeftRadius: 8,
                        bottomRightRadius: 8,
                        color: almostWhite,
                        paintingStyle: PaintingStyle.fill,
                      ),
                      tabs: [
                        Tab(
                          text: "Consolidated",
                        ),
                        Tab(
                          text: "Standalone",
                          //child: NSEtab(),
                        ),
                      ],
                    ),
                  ),
                ),
                content: Container(
                  height: ratios.consolidated.quarters.length == 0
                      ? MediaQuery.of(context).size.height * .75
                      : 1360,
                  child: TabBarView(
                    children: [
                      ratios.consolidated.quarters.length == 0
                          ? Container(
                              child: NoDataAvailablePage(),
                            )
                          : section(ratios.consolidated),
                      ratios.standalone.quarters.length == 0
                          ? NoDataAvailablePage()
                          : section(ratios.standalone),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Container section(FinancialsRatiosConsolidated data) {
    return Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 26),
        child: Column(
          children: [
            TableBarWithDropDownTitle(
              title1: "",
              isProfitLoss: false,
              title2: data.quarters[_s2],
              title3: data.quarters[_s1],
              menu: data.quarters,
              currentRightIndex: _s1,
              currentLeftIndex: _s2,
              openLeft: _openLeft,
              openRight: _openRight,
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              isTitle: true,
              title: head[0],
              value: "",
              remarks: "",
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: head[1],
              value: data.perShareRatios.basicEps[_s2],
              remarks: data.perShareRatios.basicEps[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: head[2],
              value: data.perShareRatios.dilutedEps[_s2],
              remarks: data.perShareRatios.dilutedEps[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: head[3],
              value: data.perShareRatios.bookvalueShare[_s2],
              remarks: data.perShareRatios.bookvalueShare[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: head[4],
              value: data.perShareRatios.dividendShare[_s2],
              remarks: data.perShareRatios.dividendShare[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: head[5],
              value: data.perShareRatios.faceValue[_s2],
              remarks: data.perShareRatios.faceValue[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              isTitle: true,
              title: head[6],
              value: "",
              remarks: "",
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: head[7],
              value: data.marginRatios.grossProfitMargin[_s2],
              remarks: data.marginRatios.grossProfitMargin[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: head[8],
              value: data.marginRatios.operatingMargin[_s2],
              remarks: data.marginRatios.operatingMargin[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: head[9],
              value: data.marginRatios.netProfitMargin[_s2],
              remarks: data.marginRatios.netProfitMargin[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              isTitle: true,
              title: head[10],
              value: "",
              remarks: "",
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: head[11],
              value: data.returnRatios.returnOnNetworthEquity[_s2],
              remarks: data.returnRatios.returnOnNetworthEquity[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: head[12],
              value: data.returnRatios.roce[_s2],
              remarks: data.returnRatios.roce[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: head[13],
              value: data.returnRatios.returnOnAssets[_s2],
              remarks: data.returnRatios.returnOnAssets[_s1],
            ),
            data.liquidityRatios.currentRatio.length > 0
                ? Column(
                    children: [
                      TableItem(
                        isFinancial: true,
                        isProfitLoss: true,
                        isTitle: true,
                        title: head[14],
                        value: "",
                        remarks: "",
                      ),
                      TableItem(
                        isFinancial: true,
                        isProfitLoss: true,
                        title: head[15],
                        value: data.liquidityRatios.currentRatio[_s2],
                        remarks: data.liquidityRatios.currentRatio[_s1],
                      ),
                      TableItem(
                        isFinancial: true,
                        isProfitLoss: true,
                        title: head[16],
                        value: data.liquidityRatios.quickRatio[_s2],
                        remarks: data.liquidityRatios.quickRatio[_s1],
                      ),
                    ],
                  )
                : Container(),
            data.leverageRatios.debtToEquity.length > 0
                ? Column(
                    children: [
                      TableItem(
                        isFinancial: true,
                        isProfitLoss: true,
                        isTitle: true,
                        title: head[17],
                        value: "",
                        remarks: "",
                      ),
                      TableItem(
                        isFinancial: true,
                        isProfitLoss: true,
                        title: head[18],
                        value: data.leverageRatios.debtToEquity[_s2],
                        remarks: data.leverageRatios.debtToEquity[_s1],
                      ),
                      TableItem(
                        isFinancial: true,
                        isProfitLoss: true,
                        title: head[19],
                        value: data.leverageRatios.interestCoverageRatios[_s2],
                        remarks:
                            data.leverageRatios.interestCoverageRatios[_s1],
                      ),
                    ],
                  )
                : Container(),
            data.turnoverRatios.assetTurnoverRatio.length > 0
                ? Column(
                    children: [
                      TableItem(
                        isFinancial: true,
                        isProfitLoss: true,
                        isTitle: true,
                        title: head[20],
                        value: "",
                        remarks: "",
                      ),
                      TableItem(
                        isFinancial: true,
                        isProfitLoss: true,
                        title: head[21],
                        value: data.turnoverRatios.assetTurnoverRatio[_s2],
                        remarks: data.turnoverRatios.assetTurnoverRatio[_s1],
                      ),
                      TableItem(
                        isFinancial: true,
                        isProfitLoss: true,
                        title: head[22],
                        value: data.turnoverRatios.inventoryTurnoverRatio[_s2],
                        remarks:
                            data.turnoverRatios.inventoryTurnoverRatio[_s1],
                      ),
                    ],
                  )
                : Container(),
            data.growthRatios.the3YearCagrSales.length > 0
                ? Column(
                    children: [
                      TableItem(
                        isFinancial: true,
                        isProfitLoss: true,
                        isTitle: true,
                        title: head[23],
                        value: "",
                        remarks: "",
                      ),
                      TableItem(
                        isFinancial: true,
                        isProfitLoss: true,
                        title: head[24],
                        value: data.growthRatios.the3YearCagrSales[_s2],
                        remarks: data.growthRatios.the3YearCagrSales[_s1],
                      ),
                      TableItem(
                        isFinancial: true,
                        isProfitLoss: true,
                        title: head[25],
                        value: data.growthRatios.the3YearCagrNetProfit[_s2],
                        remarks: data.growthRatios.the3YearCagrNetProfit[_s1],
                      ),
                    ],
                  )
                : Container(),
            data.valuationRatios.evEbitda.length > 0
                ? Column(
                    children: [
                      TableItem(
                        isFinancial: true,
                        isProfitLoss: true,
                        isTitle: true,
                        title: head[26],
                        value: "",
                        remarks: "",
                      ),
                      TableItem(
                        isFinancial: true,
                        isProfitLoss: true,
                        title: head[27],
                        value: data.valuationRatios.evEbitda[_s2],
                        remarks: data.valuationRatios.evEbitda[_s1],
                      ),
                      TableItem(
                        isFinancial: true,
                        isProfitLoss: true,
                        title: head[28],
                        value: data.valuationRatios.pB[_s2],
                        remarks: data.valuationRatios.pB[_s1],
                      ),
                      TableItem(
                        isFinancial: true,
                        isProfitLoss: true,
                        title: head[29],
                        value: data.valuationRatios.pE[_s2],
                        remarks: data.valuationRatios.pE[_s1],
                      ),
                      TableItem(
                        isFinancial: true,
                        isProfitLoss: true,
                        title: head[30],
                        value: data.valuationRatios.pS[_s2],
                        remarks: data.valuationRatios.pS[_s1],
                      ),
                    ],
                  )
                : Container(),
          ],
        )

        // CustomTable(
        //   scrollPhysics: NeverScrollableScrollPhysics(),
        //   headersTitle: [
        //     "",
        //     ...data.quarters.length > 5
        //         ? data.quarters.sublist(0, 5)
        //         : data.quarters.length == 0
        //             ? ["-"]
        //             : data.quarters
        //   ],
        //   fixedColumnWidth: 170,
        //   columnwidth: 80,
        //   totalColumns: data.quarters.length < 5 ? data.quarters.length + 1 : 6,
        //   itemCount: head.length,
        //   leftSideItemBuilder: (c, i) {
        //     return head[i];
        //   },
        //   rightSideChildren: [
        //     DataTableItem(
        //       height: 45,
        //       data: data.quarters.length < 5
        //           ? List<String>.filled(data.quarters.length, "")
        //           : ["", "", "", "", ""],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: [
        //         ...data.perShareRatios.basicEps.sublist(0, data.quarters.length)
        //       ],
        //     ),
        //     DataTableItem(height: 38, data: [
        //       ...data.perShareRatios.dilutedEps.sublist(0, data.quarters.length)
        //     ]),
        //     DataTableItem(height: 38, data: [
        //       ...data.perShareRatios.bookvalueShare
        //           .sublist(0, data.quarters.length)
        //     ]),
        //     DataTableItem(
        //       height: 38,
        //       data: [
        //         ...data.perShareRatios.dividendShare
        //             .sublist(0, data.quarters.length)
        //       ],
        //     ),
        //     DataTableItem(height: 38, data: [
        //       ...data.perShareRatios.faceValue.sublist(0, data.quarters.length)
        //     ]),
        //     DataTableItem(
        //       height: 45,
        //       data: data.quarters.length < 5
        //           ? List<String>.filled(data.quarters.length, "")
        //           : ["", "", "", "", ""],
        //     ),
        //     DataTableItem(height: 38, data: [
        //       ...data.marginRatios.grossProfitMargin
        //           .sublist(0, data.quarters.length),
        //     ]),
        //     DataTableItem(
        //       height: 38,
        //       data: [
        //         ...data.marginRatios.operatingMargin
        //             .sublist(0, data.quarters.length)
        //       ],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: [
        //         ...data.marginRatios.netProfitMargin
        //             .sublist(0, data.quarters.length)
        //       ],
        //     ),
        //     DataTableItem(
        //       height: 45,
        //       data: data.quarters.length < 5
        //           ? List<String>.filled(data.quarters.length, "")
        //           : ["", "", "", "", ""],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: [
        //         ...data.returnRatios.returnOnNetworthEquity
        //             .sublist(0, data.quarters.length)
        //       ],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: [...data.returnRatios.roce.sublist(0, data.quarters.length)],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: [
        //         ...data.returnRatios.returnOnAssets
        //             .sublist(0, data.quarters.length)
        //       ],
        //     ),
        //     DataTableItem(
        //       height: 45,
        //       data: data.quarters.length < 5
        //           ? List<String>.filled(data.quarters.length, "")
        //           : ["", "", "", "", ""],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: [
        //         ...data.liquidityRatios.currentRatio
        //             .sublist(0, data.quarters.length)
        //       ],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: [
        //         ...data.liquidityRatios.quickRatio
        //             .sublist(0, data.quarters.length)
        //       ],
        //     ),
        //     DataTableItem(
        //       height: 45,
        //       data: data.quarters.length < 5
        //           ? List<String>.filled(data.quarters.length, "")
        //           : ["", "", "", "", ""],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: [
        //         ...data.leverageRatios.debtToEquity
        //             .sublist(0, data.quarters.length)
        //       ],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: [
        //         ...data.leverageRatios.interestCoverageRatios
        //             .sublist(0, data.quarters.length)
        //       ],
        //     ),
        //     DataTableItem(
        //       height: 45,
        //       data: data.quarters.length < 5
        //           ? List<String>.filled(data.quarters.length, "")
        //           : ["", "", "", "", ""],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: [
        //         ...data.turnoverRatios.assetTurnoverRatio
        //             .sublist(0, data.quarters.length)
        //       ],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: [
        //         ...data.turnoverRatios.inventoryTurnoverRatio
        //             .sublist(0, data.quarters.length)
        //       ],
        //     ),
        //     DataTableItem(
        //       height: 45,
        //       data: data.quarters.length < 5
        //           ? List<String>.filled(data.quarters.length, "")
        //           : ["", "", "", "", ""],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: [
        //         ...data.growthRatios.the3YearCagrSales
        //             .sublist(0, data.quarters.length)
        //       ],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: [
        //         ...data.growthRatios.the3YearCagrNetProfit
        //             .sublist(0, data.quarters.length)
        //       ],
        //     ),
        //     DataTableItem(
        //       height: 45,
        //       data: data.quarters.length < 5
        //           ? List<String>.filled(data.quarters.length, "")
        //           : ["", "", "", "", ""],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: [
        //         ...data.valuationRatios.evEbitda.sublist(0, data.quarters.length)
        //       ],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: [...data.valuationRatios.pB.sublist(0, data.quarters.length)],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: [...data.valuationRatios.pE.sublist(0, data.quarters.length)],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: [...data.valuationRatios.pS.sublist(0, data.quarters.length)],
        //     ),
        //   ],
        // ),
        );
  }

  static Widget heading(String s) {
    return Container(
      height: 45,
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(s, textAlign: TextAlign.left, style: subtitle1White)),
    );
  }

  static Widget text(String s) {
    return Container(
      height: 38,
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(s, textAlign: TextAlign.left, style: bodyText2White60)),
    );
  }
}
