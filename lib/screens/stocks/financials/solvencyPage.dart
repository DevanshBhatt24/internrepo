import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/components/slidePanel.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/widgets/miss.dart';
import 'package:technical_ind/widgets/tableItem.dart';
import '../../../styles.dart';
import 'financialPage.dart';

class SolvencyPage extends StatefulWidget {
  final FinancialsSolvency financialsSolvency;
  final String title;
  SolvencyPage({Key key, this.financialsSolvency, this.title})
      : super(key: key);

  @override
  _SolvencyPageState createState() => _SolvencyPageState();
}

class _SolvencyPageState extends State<SolvencyPage> {
  static final List<String> w2014 = [
    '15.9254',
    '0.0',
    '0.06',
    '0.0398',
    '0.0',
    '0.004',
    '0.0',
    '0.0',
    '1.74',
    '16.74',
    '1.77',
    '0.1729',
    '0.8271',
    '0.0',
    '9.02'
  ];

  List<String> head = [
    "Capitalization Ratio",
    "Interest Coverage",
    "Long Term Debt to EBIDTA",
    "Long Term Debt to Equity (Net Worth)",
    "Solvency Ratio",
    "Dividend Payout",
    "Retention Ratio",
    "Times Interest Earned",
    "Cash Ratio",
    "Accurals",
    "CFO to Debt",
    "Debt To Assets",
    "Debt To Capital",
    "Assets to Share-holder Equity",
    "Dividend Cover",
  ];

  List<String> menu = [];
  List<String> menu1 = [];
  List<String> menu2 = [];
  int _s1 = 1;
  int _s2 = 0;
  int _currentLeftPanel = 0;
  int _currentRightPanel = 0;

  bool isRight = false;

  _openRight(List<String> newMenu, int i) {
    setState(() {
      menu = newMenu;
      _currentRightPanel = i;
      isRight = true;
    });
    _panelController.open();
  }

  PanelController _panelController = PanelController();

  _openLeft(List<String> newMenu, int i) {
    setState(() {
      menu = newMenu;
      _currentLeftPanel = i;
      isRight = false;
    });
    _panelController.open();
  }

  FinancialsSolvency financialsSolvency;
  @override
  void initState() {
    super.initState();
    financialsSolvency = widget.financialsSolvency;
    menu1 = financialsSolvency.riskPriceAndValuations.years;
    menu2 = financialsSolvency.compoundAnnualGrowthRate.period;
    menu = menu1 ?? [];
  }

  final data1 = [w2014, w2014, w2014, w2014, w2014];
  @override
  Widget build(BuildContext context) {
    return SlidePanel(
      menu: menu,
      defaultWidget: menu.length != 0 ? (isRight ? menu[_s1] : menu[_s2]) : "",
      onChange: (val) {
        setState(() {
          isRight ? _s1 = val : _s2 = val;
        });
      },
      panelController: _panelController,
      child: Scaffold(
        appBar: customAppBar(
          
            title: "Solvency", subtitle: widget.title, context: context),
        body: financialsSolvency == null
            ? NoDataAvailablePage()
            : financialsSolvency.riskPriceAndValuations.years.isEmpty
                ? NoDataAvailablePage()
                : SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // SizedBox(height: 18),
                          // Text('Risk, Price & Valuations', style: subtitle1White),
                          SizedBox(height: 18),
                          Container(
                              height: 800,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 22),
                                    TableBarWithDropDownTitle(
                                        title1: "Year",
                                        title2: menu1[_s2],
                                        title3: menu1[_s1],
                                        menu: menu1,
                                        currentRightIndex: _s1,
                                        currentLeftIndex: _s2,
                                        openRight: _openRight,
                                        openLeft: _openLeft),
                                    Column(
                                        children: List.generate(
                                      head.length,
                                      (i) {
                                        var d;
                                        if (i == 0) {
                                          d = financialsSolvency
                                                  .riskPriceAndValuations
                                                  .capitalizationRatio ??
                                              [];
                                        } else if (i == 1) {
                                          d = financialsSolvency
                                                  .riskPriceAndValuations
                                                  .interestCoverage ??
                                              [];
                                        } else if (i == 2) {
                                          d = financialsSolvency
                                                  .riskPriceAndValuations
                                                  .longTermDebtToEbidta ??
                                              [];
                                        } else if (i == 3) {
                                          d = financialsSolvency
                                                  .riskPriceAndValuations
                                                  .longTermDebtToEquityNetWorth ??
                                              [];
                                        } else if (i == 4) {
                                          d = financialsSolvency
                                                  .riskPriceAndValuations
                                                  .solvencyRatio ??
                                              [];
                                        } else if (i == 5) {
                                          d = financialsSolvency
                                                  .riskPriceAndValuations
                                                  .dividendPayout ??
                                              [];
                                        } else if (i == 6) {
                                          d = financialsSolvency
                                                  .riskPriceAndValuations
                                                  .dividendPayout ??
                                              [];
                                        } else if (i == 7) {
                                          d = financialsSolvency
                                                  .riskPriceAndValuations
                                                  .retentionRatio ??
                                              [];
                                        } else if (i == 8) {
                                          d = financialsSolvency
                                                  .riskPriceAndValuations
                                                  .timesInterestEarned ??
                                              [];
                                        } else if (i == 9) {
                                          d = financialsSolvency
                                                  .riskPriceAndValuations
                                                  .cashRatio ??
                                              [];
                                        } else if (i == 10) {
                                          d = financialsSolvency
                                                  .riskPriceAndValuations
                                                  .accurals ??
                                              [];
                                        } else if (i == 11) {
                                          d = financialsSolvency
                                                  .riskPriceAndValuations
                                                  .cfoToDebt ??
                                              [];
                                        } else if (i == 12) {
                                          d = financialsSolvency
                                                  .riskPriceAndValuations
                                                  .debtToAssets ??
                                              [];
                                        } else if (i == 13) {
                                          d = financialsSolvency
                                                  .riskPriceAndValuations
                                                  .debtToCapital ??
                                              [];
                                        } else if (i == 14) {
                                          d = financialsSolvency
                                                  .riskPriceAndValuations
                                                  .assetsToShareholderEquity ??
                                              [];
                                        } else if (i == 15) {
                                          d = financialsSolvency
                                                  .riskPriceAndValuations
                                                  .dividendCover ??
                                              [];
                                        }
                                        return TableItem(
                                          isFinancial: true,
                                          title: head[i],
                                          value:
                                              d.length != 0 ? d[_s2] : "" ?? "",
                                          remarks:
                                              d.length != 0 ? d[_s1] : "" ?? "",
                                        );
                                      },
                                    )),
                                    SizedBox(height: 22),
                                  ])),

                          // CustomTable(
                          //   scrollPhysics: NeverScrollableScrollPhysics(),
                          //   headersTitle: [
                          //     "Year",
                          // ...financialsSolvency
                          //     .riskPriceAndValuations.years,
                          //   ],
                          //   fixedColumnWidth: 0.34.sw,
                          //   columnwidth: 0.25.sw,
                          //   totalColumns: financialsSolvency
                          //               .riskPriceAndValuations.years.length >
                          //           5
                          //       ? 6
                          //       : financialsSolvency
                          //               .riskPriceAndValuations.years.length +
                          //           1,
                          //   itemCount: head.length,
                          //   leftSideItemBuilder: (c, i) {
                          //     return text(head[i]);
                          //   },
                          //   rightSideItemBuilder: (c, i) {
                          // var d;
                          // if (i == 0) {
                          //   d = financialsSolvency.riskPriceAndValuations
                          //           .capitalizationRatio ??
                          //       [];
                          // } else if (i == 1) {
                          //   d = financialsSolvency.riskPriceAndValuations
                          //           .interestCoverage ??
                          //       [];
                          // } else if (i == 2) {
                          //   d = financialsSolvency.riskPriceAndValuations
                          //           .longTermDebtToEbidta ??
                          //       [];
                          // } else if (i == 3) {
                          //   d = financialsSolvency.riskPriceAndValuations
                          //           .longTermDebtToEquityNetWorth ??
                          //       [];
                          // } else if (i == 4) {
                          //   d = financialsSolvency
                          //           .riskPriceAndValuations.solvencyRatio ??
                          //       [];
                          // } else if (i == 5) {
                          //   d = financialsSolvency.riskPriceAndValuations
                          //           .dividendPayout ??
                          //       [];
                          // } else if (i == 6) {
                          //   d = financialsSolvency.riskPriceAndValuations
                          //           .dividendPayout ??
                          //       [];
                          // } else if (i == 7) {
                          //   d = financialsSolvency.riskPriceAndValuations
                          //           .retentionRatio ??
                          //       [];
                          // } else if (i == 8) {
                          //   d = financialsSolvency.riskPriceAndValuations
                          //           .timesInterestEarned ??
                          //       [];
                          // } else if (i == 9) {
                          //   d = financialsSolvency
                          //           .riskPriceAndValuations.cashRatio ??
                          //       [];
                          // } else if (i == 10) {
                          //   d = financialsSolvency
                          //           .riskPriceAndValuations.accurals ??
                          //       [];
                          // } else if (i == 11) {
                          //   d = financialsSolvency
                          //           .riskPriceAndValuations.cfoToDebt ??
                          //       [];
                          // } else if (i == 12) {
                          //   d = financialsSolvency
                          //           .riskPriceAndValuations.debtToAssets ??
                          //       [];
                          // } else if (i == 13) {
                          //   d = financialsSolvency
                          //           .riskPriceAndValuations.debtToCapital ??
                          //       [];
                          // } else if (i == 14) {
                          //   d = financialsSolvency.riskPriceAndValuations
                          //           .assetsToShareholderEquity ??
                          //       [];
                          // } else if (i == 15) {
                          //   d = financialsSolvency
                          //           .riskPriceAndValuations.dividendCover ??
                          //       [];
                          // }
                          //     return Center(
                          //       child: Container(
                          //         height: 50,
                          //         padding: EdgeInsets.symmetric(horizontal: 0),
                          //         child: Center(
                          //           child: Row(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: List.generate(
                          //               d.length > 5 ? 5 : d.length,
                          //               (index) => Container(
                          //                 width: 0.25.sw,
                          //                 child: Text(d[index],
                          //                     textAlign: TextAlign.center,
                          //                     style: bodyText2White),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),
                          // ),
                          Text('Compound Annual Growth Rate',
                              style: subtitle1White),
                          SizedBox(height: 18),
                          Container(
                              height: 800,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 22),
                                    TableBarWithDropDownTitle(
                                        title1: "Year",
                                        title2: menu2[_s2],
                                        title3: menu2[_s1],
                                        menu: menu2,
                                        currentRightIndex: _s1,
                                        currentLeftIndex: _s2,
                                        openRight: _openRight,
                                        openLeft: _openLeft),
                                    Column(
                                        children: List.generate(
                                      head.length,
                                      (i) {
                                        var d;
                                        if (i == 0) {
                                          d = financialsSolvency
                                                  .compoundAnnualGrowthRate
                                                  .capitalizationRatio ??
                                              [];
                                        } else if (i == 1) {
                                          d = financialsSolvency
                                                  .compoundAnnualGrowthRate
                                                  .interestCoverage ??
                                              [];
                                        } else if (i == 2) {
                                          d = financialsSolvency
                                                  .compoundAnnualGrowthRate
                                                  .longTermDebtToEbidta ??
                                              [];
                                        } else if (i == 3) {
                                          d = financialsSolvency
                                                  .compoundAnnualGrowthRate
                                                  .longTermDebtToEquityNetWorth ??
                                              [];
                                        } else if (i == 4) {
                                          d = financialsSolvency
                                                  .compoundAnnualGrowthRate
                                                  .solvencyRatio ??
                                              [];
                                        } else if (i == 5) {
                                          d = financialsSolvency
                                                  .compoundAnnualGrowthRate
                                                  .dividendPayout ??
                                              [];
                                        } else if (i == 6) {
                                          d = financialsSolvency
                                                  .compoundAnnualGrowthRate
                                                  .dividendPayout ??
                                              [];
                                        } else if (i == 7) {
                                          d = financialsSolvency
                                                  .compoundAnnualGrowthRate
                                                  .retentionRatio ??
                                              [];
                                        } else if (i == 8) {
                                          d = financialsSolvency
                                                  .compoundAnnualGrowthRate
                                                  .timesInterestEarned ??
                                              [];
                                        } else if (i == 9) {
                                          d = financialsSolvency
                                                  .compoundAnnualGrowthRate
                                                  .cashRatio ??
                                              [];
                                        } else if (i == 10) {
                                          d = financialsSolvency
                                                  .compoundAnnualGrowthRate
                                                  .accurals ??
                                              [];
                                        } else if (i == 11) {
                                          d = financialsSolvency
                                                  .compoundAnnualGrowthRate
                                                  .cfoToDebt ??
                                              [];
                                        } else if (i == 12) {
                                          d = financialsSolvency
                                                  .compoundAnnualGrowthRate
                                                  .debtToAssets ??
                                              [];
                                        } else if (i == 13) {
                                          d = financialsSolvency
                                                  .compoundAnnualGrowthRate
                                                  .debtToCapital ??
                                              [];
                                        } else if (i == 14) {
                                          d = financialsSolvency
                                                  .compoundAnnualGrowthRate
                                                  .assetsToShareholderEquity ??
                                              [];
                                        } else if (i == 15) {
                                          d = financialsSolvency
                                                  .compoundAnnualGrowthRate
                                                  .dividendCover ??
                                              [];
                                        }
                                        return TableItem(
                                          isFinancial: true,
                                          title: head[i],
                                          value:
                                              d.length != 0 ? d[_s2] : "" ?? "",
                                          remarks:
                                              d.length != 0 ? d[_s1] : "" ?? "",
                                        );
                                      },
                                    )),
                                    SizedBox(height: 22),
                                  ])),

                          // CustomTable(
                          //   scrollPhysics: NeverScrollableScrollPhysics(),
                          //   headersTitle: [
                          //     "Year",
                          //     ...financialsSolvency
                          //         .compoundAnnualGrowthRate.period,
                          //   ],
                          //   fixedColumnWidth: 0.34.sw,
                          //   columnwidth: 0.25.sw,
                          //   totalColumns: financialsSolvency
                          //           .compoundAnnualGrowthRate.period.length +
                          //       1,
                          //   itemCount: head.length,
                          //   leftSideItemBuilder: (c, i) {
                          //     return text(head[i]);
                          //   },
                          //   rightSideItemBuilder: (c, i) {
                          // var d;
                          // if (i == 0) {
                          //   d = financialsSolvency
                          //           .compoundAnnualGrowthRate
                          //           .capitalizationRatio ??
                          //       [];
                          // } else if (i == 1) {
                          //   d = financialsSolvency
                          //           .compoundAnnualGrowthRate
                          //           .interestCoverage ??
                          //       [];
                          // } else if (i == 2) {
                          //   d = financialsSolvency
                          //           .compoundAnnualGrowthRate
                          //           .longTermDebtToEbidta ??
                          //       [];
                          // } else if (i == 3) {
                          //   d = financialsSolvency
                          //           .compoundAnnualGrowthRate
                          //           .longTermDebtToEquityNetWorth ??
                          //       [];
                          // } else if (i == 4) {
                          //   d = financialsSolvency
                          //           .compoundAnnualGrowthRate
                          //           .solvencyRatio ??
                          //       [];
                          // } else if (i == 5) {
                          //   d = financialsSolvency
                          //           .compoundAnnualGrowthRate
                          //           .dividendPayout ??
                          //       [];
                          // } else if (i == 6) {
                          //   d = financialsSolvency
                          //           .compoundAnnualGrowthRate
                          //           .dividendPayout ??
                          //       [];
                          // } else if (i == 7) {
                          //   d = financialsSolvency
                          //           .compoundAnnualGrowthRate
                          //           .retentionRatio ??
                          //       [];
                          // } else if (i == 8) {
                          //   d = financialsSolvency
                          //           .compoundAnnualGrowthRate
                          //           .timesInterestEarned ??
                          //       [];
                          // } else if (i == 9) {
                          //   d = financialsSolvency
                          //           .compoundAnnualGrowthRate.cashRatio ??
                          //       [];
                          // } else if (i == 10) {
                          //   d = financialsSolvency
                          //           .compoundAnnualGrowthRate.accurals ??
                          //       [];
                          // } else if (i == 11) {
                          //   d = financialsSolvency
                          //           .compoundAnnualGrowthRate.cfoToDebt ??
                          //       [];
                          // } else if (i == 12) {
                          //   d = financialsSolvency
                          //           .compoundAnnualGrowthRate
                          //           .debtToAssets ??
                          //       [];
                          // } else if (i == 13) {
                          //   d = financialsSolvency
                          //           .compoundAnnualGrowthRate
                          //           .debtToCapital ??
                          //       [];
                          // } else if (i == 14) {
                          //   d = financialsSolvency
                          //           .compoundAnnualGrowthRate
                          //           .assetsToShareholderEquity ??
                          //       [];
                          // } else if (i == 15) {
                          //   d = financialsSolvency
                          //           .compoundAnnualGrowthRate
                          //           .dividendCover ??
                          //       [];
                          // }
                          //     return Center(
                          //       child: Container(
                          //         height: 50,
                          //         padding: EdgeInsets.symmetric(
                          //             horizontal: 0, vertical: 16),
                          //         child: Center(
                          //           child: Row(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: List.generate(
                          //               d.length,
                          //               (index) => Container(
                          //                 width: 0.25.sw,
                          //                 child: Text(d[index],
                          //                     textAlign: TextAlign.center,
                          //                     style: bodyText2White),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),
                          // ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  Widget text(String s) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(s, textAlign: TextAlign.left, style: bodyText2White60),
      ),
    );
  }
}
