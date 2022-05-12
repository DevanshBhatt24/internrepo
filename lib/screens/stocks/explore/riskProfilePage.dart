import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/components/slidePanel.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/widgets/miss.dart';
import 'package:technical_ind/widgets/tableItem.dart';
import '../../../styles.dart';
import '../financials/financialPage.dart';

class RiskProfilePage extends StatefulWidget {
  final FinancialsRiskProfile financialsRiskProfile;
  final String title;
  RiskProfilePage({Key key, this.financialsRiskProfile, this.title})
      : super(key: key);

  @override
  _RiskProfilePageState createState() => _RiskProfilePageState();
}

class _RiskProfilePageState extends State<RiskProfilePage> {
  final List<String> head = [
    'Market Cap',
    'Dividend Yield',
    'Earning Yield',
    'Account Cost of Debit',
    'Cost of Equity (CAPM Model)',
    'Credit/Default Spread',
    'Levered Beta',
    'PEG (Price by earning to Growth)',
    'PBV (Price to Book Value)',
    'PE (Price to Earning)',
    'PS (Price to Sales-Revenue)',
    'Weight to debt (WACC)',
    'Weight of equity (WACC)',
    'WACC (Weighted cost of Capital)',
    'PCFO(Price to cash Flow from Opts)',
    'Enterprise value'
  ];

  FinancialsRiskProfile financialsRiskProfile;
  @override
  void initState() {
    super.initState();
    financialsRiskProfile = widget.financialsRiskProfile;
    menu1 = financialsRiskProfile.riskPriceAndValuations.years;
    menu2 = financialsRiskProfile.compoundAnnualGrowthRate.period;
    menu = menu1;
  }

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
          title: "Risk Profile",
          subtitle: widget.title,
          context: context,
        ),
        body: financialsRiskProfile.riskPriceAndValuations.marketCap.isEmpty &&
                financialsRiskProfile
                    .riskPriceAndValuations.accountCostOfDebit.isEmpty &&
                financialsRiskProfile.riskPriceAndValuations
                    .compoundAnnualGrowthRateCostOfEquityCapmModel.isEmpty
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
                          height: 900,
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
                                      d = financialsRiskProfile
                                              .riskPriceAndValuations
                                              .marketCap ??
                                          [];
                                    } else if (i == 1) {
                                      d = financialsRiskProfile
                                              .riskPriceAndValuations
                                              .dividendYield ??
                                          [];
                                    } else if (i == 2) {
                                      d = financialsRiskProfile
                                              .riskPriceAndValuations
                                              .earningYield ??
                                          [];
                                    } else if (i == 3) {
                                      d = financialsRiskProfile
                                              .riskPriceAndValuations
                                              .accountCostOfDebit ??
                                          [];
                                    } else if (i == 4) {
                                      d = financialsRiskProfile
                                              .riskPriceAndValuations
                                              .costOfEquityCapmModel ??
                                          [];
                                    } else if (i == 5) {
                                      d = financialsRiskProfile
                                              .riskPriceAndValuations
                                              .creditDefaultSpread ??
                                          [];
                                    } else if (i == 6) {
                                      d = financialsRiskProfile
                                              .riskPriceAndValuations
                                              .leveredBeta ??
                                          [];
                                    } else if (i == 7) {
                                      d = financialsRiskProfile
                                              .riskPriceAndValuations
                                              .pegPriceByEarningToGrowth ??
                                          [];
                                    } else if (i == 8) {
                                      d = financialsRiskProfile
                                              .riskPriceAndValuations
                                              .pbvPriceToBookValue ??
                                          [];
                                    } else if (i == 9) {
                                      d = financialsRiskProfile
                                              .riskPriceAndValuations
                                              .pePriceToEarning ??
                                          [];
                                    } else if (i == 10) {
                                      d = financialsRiskProfile
                                              .riskPriceAndValuations
                                              .psPriceToSalesRevenue ??
                                          [];
                                    } else if (i == 11) {
                                      d = financialsRiskProfile
                                              .riskPriceAndValuations
                                              .weightToDebtWacc ??
                                          [];
                                    } else if (i == 12) {
                                      d = financialsRiskProfile
                                              .riskPriceAndValuations
                                              .weightOfEquityWacc ??
                                          [];
                                    } else if (i == 13) {
                                      d = financialsRiskProfile
                                              .riskPriceAndValuations
                                              .waccWightedCostOfCapital ??
                                          [];
                                    } else if (i == 14) {
                                      d = financialsRiskProfile
                                              .riskPriceAndValuations
                                              .pcfoPriceToCashFlowFromOperations ??
                                          [];
                                    } else {
                                      d = financialsRiskProfile
                                              .riskPriceAndValuations
                                              .enterpriceValue ??
                                          [];
                                    }
                                    return TableItem(
                                      isFinancial: true,
                                      title: head[i],
                                      value: d.length != 0 ? d[_s2] : "" ?? "",
                                      remarks:
                                          d.length != 0 ? d[_s1] : "" ?? "",
                                    );
                                  },
                                )),
                                SizedBox(height: 22),
                              ])
                          // CustomTable(
                          //   scrollPhysics: NeverScrollableScrollPhysics(),
                          //   headersTitle: [
                          //     "Year",
                          //     ...financialsRiskProfile.riskPriceAndValuations.years,
                          //   ],
                          //   fixedColumnWidth: 0.34.sw,
                          //   columnwidth: 0.25.sw,
                          //   totalColumns: financialsRiskProfile
                          //           .riskPriceAndValuations.years.length +
                          //       1,
                          //   itemCount: head.length,
                          //   leftSideItemBuilder: (c, i) {
                          //     return text(head[i]);
                          //   },
                          //   rightSideItemBuilder: (c, i) {
                          //     print(i);
                          // var d;
                          // if (i == 0) {
                          //   d = financialsRiskProfile
                          //           .riskPriceAndValuations.marketCap ??
                          //       [];
                          // } else if (i == 1) {
                          //   d = financialsRiskProfile
                          //           .riskPriceAndValuations.dividendYield ??
                          //       [];
                          // } else if (i == 2) {
                          //   d = financialsRiskProfile
                          //           .riskPriceAndValuations.earningYield ??
                          //       [];
                          // } else if (i == 3) {
                          //   d = financialsRiskProfile.riskPriceAndValuations
                          //           .accountCostOfDebit ??
                          //       [];
                          // } else if (i == 4) {
                          //   d = financialsRiskProfile.riskPriceAndValuations
                          //           .costOfEquityCapmModel ??
                          //       [];
                          // } else if (i == 5) {
                          //   d = financialsRiskProfile.riskPriceAndValuations
                          //           .creditDefaultSpread ??
                          //       [];
                          // } else if (i == 6) {
                          //   d = financialsRiskProfile
                          //           .riskPriceAndValuations.leveredBeta ??
                          //       [];
                          // } else if (i == 7) {
                          //   d = financialsRiskProfile.riskPriceAndValuations
                          //           .pegPriceByEarningToGrowth ??
                          //       [];
                          // } else if (i == 8) {
                          //   d = financialsRiskProfile.riskPriceAndValuations
                          //           .pbvPriceToBookValue ??
                          //       [];
                          // } else if (i == 9) {
                          //   d = financialsRiskProfile
                          //           .riskPriceAndValuations.pePriceToEarning ??
                          //       [];
                          // } else if (i == 10) {
                          //   d = financialsRiskProfile.riskPriceAndValuations
                          //           .psPriceToSalesRevenue ??
                          //       [];
                          // } else if (i == 11) {
                          //   d = financialsRiskProfile
                          //           .riskPriceAndValuations.weightToDebtWacc ??
                          //       [];
                          // } else if (i == 12) {
                          //   d = financialsRiskProfile.riskPriceAndValuations
                          //           .weightOfEquityWacc ??
                          //       [];
                          // } else if (i == 13) {
                          //   d = financialsRiskProfile.riskPriceAndValuations
                          //           .waccWightedCostOfCapital ??
                          //       [];
                          // } else if (i == 14) {
                          //   d = financialsRiskProfile.riskPriceAndValuations
                          //           .pcfoPriceToCashFlowFromOperations ??
                          //       [];
                          // } else {
                          //   d = financialsRiskProfile
                          //           .riskPriceAndValuations.enterpriceValue ??
                          //       [];
                          // }
                          //     print(d);
                          //     return Center(
                          //       child: Container(
                          //         height: 50,
                          //         // padding: EdgeInsets.symmetric(horizontal: 0),
                          //         child: Center(
                          //           child: Row(
                          //             crossAxisAlignment: CrossAxisAlignment.start,
                          //             children: List.generate(
                          //               d.length,
                          //               (index) {
                          //                 return Container(
                          //                   width: 0.25.sw,
                          //                   child: Text(d[index],
                          //                       textAlign: TextAlign.center,
                          //                       style: bodyText2White),
                          //                 );
                          //               },
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),
                          ),
                      Text('Compound Annual Growth Rate',
                          style: subtitle1White),
                      SizedBox(height: 18),
                      Container(
                          height: 900,
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
                                      d = financialsRiskProfile
                                              .compoundAnnualGrowthRate
                                              .marketCap ??
                                          [];
                                    } else if (i == 1) {
                                      d = financialsRiskProfile
                                              .compoundAnnualGrowthRate
                                              .dividendYield ??
                                          [];
                                    } else if (i == 2) {
                                      d = financialsRiskProfile
                                              .compoundAnnualGrowthRate
                                              .earningYield ??
                                          [];
                                    } else if (i == 3) {
                                      d = financialsRiskProfile
                                              .compoundAnnualGrowthRate
                                              .accountCostOfDebit ??
                                          [];
                                    } else if (i == 4) {
                                      d = financialsRiskProfile
                                              .compoundAnnualGrowthRate
                                              .costOfEquityCapmModel ??
                                          [];
                                    } else if (i == 5) {
                                      d = financialsRiskProfile
                                              .compoundAnnualGrowthRate
                                              .creditDefaultSpread ??
                                          [];
                                    } else if (i == 6) {
                                      d = financialsRiskProfile
                                              .compoundAnnualGrowthRate
                                              .leveredBeta ??
                                          [];
                                    } else if (i == 7) {
                                      d = financialsRiskProfile
                                              .compoundAnnualGrowthRate
                                              .pegPriceByEarningToGrowth ??
                                          [];
                                    } else if (i == 8) {
                                      d = financialsRiskProfile
                                              .compoundAnnualGrowthRate
                                              .pbvPriceToBookValue ??
                                          [];
                                    } else if (i == 9) {
                                      d = financialsRiskProfile
                                              .compoundAnnualGrowthRate
                                              .pePriceToEarning ??
                                          [];
                                    } else if (i == 10) {
                                      d = financialsRiskProfile
                                              .compoundAnnualGrowthRate
                                              .psPriceToSalesRevenue ??
                                          [];
                                    } else if (i == 11) {
                                      d = financialsRiskProfile
                                              .compoundAnnualGrowthRate
                                              .weightToDebtWacc ??
                                          [];
                                    } else if (i == 12) {
                                      d = financialsRiskProfile
                                              .compoundAnnualGrowthRate
                                              .weightOfEquityWacc ??
                                          [];
                                    } else if (i == 13) {
                                      d = financialsRiskProfile
                                              .compoundAnnualGrowthRate
                                              .waccWightedCostOfCapital ??
                                          [];
                                    } else if (i == 14) {
                                      d = financialsRiskProfile
                                              .compoundAnnualGrowthRate
                                              .pcfoPriceToCashFlowFromOperations ??
                                          [];
                                    } else if (i == 15) {
                                      d = financialsRiskProfile
                                              .compoundAnnualGrowthRate
                                              .enterpriceValue ??
                                          [];
                                    }
                                    return TableItem(
                                      isFinancial: true,
                                      title: head[i],
                                      value: d.length != 0 ? d[_s2] : "" ?? "",
                                      remarks:
                                          d.length != 0 ? d[_s1] : "" ?? "",
                                    );
                                  },
                                )),
                                SizedBox(height: 22),
                              ])
                          // CustomTable(
                          //   scrollPhysics: NeverScrollableScrollPhysics(),
                          //   headersTitle: [
                          //     "Year",
                          //     ...financialsRiskProfile
                          //         .compoundAnnualGrowthRate.period,
                          //   ],
                          //   fixedColumnWidth: 0.34.sw,
                          //   columnwidth: 0.25.sw,
                          //   totalColumns: financialsRiskProfile
                          //           .compoundAnnualGrowthRate.period.length +
                          //       1,
                          //   itemCount: head.length,
                          //   leftSideItemBuilder: (c, i) {
                          //     return text(head[i]);
                          //   },
                          //   rightSideItemBuilder: (c, i) {
                          // var d;
                          // if (i == 0) {
                          //   d = financialsRiskProfile
                          //           .compoundAnnualGrowthRate.marketCap ??
                          //       [];
                          // } else if (i == 1) {
                          //   d = financialsRiskProfile
                          //           .compoundAnnualGrowthRate.dividendYield ??
                          //       [];
                          // } else if (i == 2) {
                          //   d = financialsRiskProfile
                          //           .compoundAnnualGrowthRate.earningYield ??
                          //       [];
                          // } else if (i == 3) {
                          //   d = financialsRiskProfile.compoundAnnualGrowthRate
                          //           .accountCostOfDebit ??
                          //       [];
                          // } else if (i == 4) {
                          //   d = financialsRiskProfile.compoundAnnualGrowthRate
                          //           .costOfEquityCapmModel ??
                          //       [];
                          // } else if (i == 5) {
                          //   d = financialsRiskProfile.compoundAnnualGrowthRate
                          //           .creditDefaultSpread ??
                          //       [];
                          // } else if (i == 6) {
                          //   d = financialsRiskProfile
                          //           .compoundAnnualGrowthRate.leveredBeta ??
                          //       [];
                          // } else if (i == 7) {
                          //   d = financialsRiskProfile.compoundAnnualGrowthRate
                          //           .pegPriceByEarningToGrowth ??
                          //       [];
                          // } else if (i == 8) {
                          //   d = financialsRiskProfile.compoundAnnualGrowthRate
                          //           .pbvPriceToBookValue ??
                          //       [];
                          // } else if (i == 9) {
                          //   d = financialsRiskProfile.compoundAnnualGrowthRate
                          //           .pePriceToEarning ??
                          //       [];
                          // } else if (i == 10) {
                          //   d = financialsRiskProfile.compoundAnnualGrowthRate
                          //           .psPriceToSalesRevenue ??
                          //       [];
                          // } else if (i == 11) {
                          //   d = financialsRiskProfile.compoundAnnualGrowthRate
                          //           .weightToDebtWacc ??
                          //       [];
                          // } else if (i == 12) {
                          //   d = financialsRiskProfile.compoundAnnualGrowthRate
                          //           .weightOfEquityWacc ??
                          //       [];
                          // } else if (i == 13) {
                          //   d = financialsRiskProfile.compoundAnnualGrowthRate
                          //           .waccWightedCostOfCapital ??
                          //       [];
                          // } else if (i == 14) {
                          //   d = financialsRiskProfile.compoundAnnualGrowthRate
                          //           .pcfoPriceToCashFlowFromOperations ??
                          //       [];
                          // } else if (i == 15) {
                          //   d = financialsRiskProfile.compoundAnnualGrowthRate
                          //           .enterpriceValue ??
                          //       [];
                          // }

                          //     return Center(
                          //       child: Container(
                          //         height: 50,
                          //         // padding:
                          //         // EdgeInsets.symmetric(horizontal: 0, vertical: 16),
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
                          ),
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
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Text(s, textAlign: TextAlign.left, style: bodyText2White60),
      ),
    );
  }
}
