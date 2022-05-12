import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/components/slidePanel.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/widgets/miss.dart';
import 'package:technical_ind/widgets/tableItem.dart';

import '../../../styles.dart';
import '../../../widgets/datagrid.dart';
import 'financialPage.dart';

class DividendPage extends StatefulWidget {
  final FinancialsDividends financialsDividends;
  final String title;
  DividendPage({Key key, this.financialsDividends, this.title})
      : super(key: key);

  @override
  _DividendPageState createState() => _DividendPageState();
}

class _DividendPageState extends State<DividendPage> {
  List<String> titles = [
    "Dividend (Yield)",
    "Payout Ratio",
    "Annualized payout",
    "Annualized Growth Last 5 Years"
  ];
  List<String> dividend = [
    "Dividend",
    "EPS Payout Ratio",
    "Type",
    "Payment Date",
    "Yield"
  ];

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

  List<String> menu = [];
  int _s1 = 1;
  int _s2 = 0;
  int _currentLeftPanel = 0;
  int _currentRightPanel = 0;

  _openLeft(List<String> newMenu, int i) {
    setState(() {
      menu = newMenu;
      _currentLeftPanel = i;
      isRight = false;
    });
    _panelController.open();
  }

  List<String> dates = ["2.6", "74 %", "TTM", "27 Jul 2017", "1.05"];
  FinancialsDividends financialsDividends;
  @override
  void initState() {
    super.initState();
    financialsDividends = widget.financialsDividends;
    menu = financialsDividends.dividendYieldPart.paymentDate;
  }

  @override
  Widget build(BuildContext context) {
    return SlidePanel(
      menu: menu,
      defaultWidget: isRight ? menu[_s1] : menu[_s2],
      onChange: (val) {
        setState(() {
          isRight ? _s1 = val : _s2 = val;
        });
      },
      panelController: _panelController,
      child: Scaffold(
        appBar: customAppBar(
            title: "Dividend", subtitle: widget.title, context: context),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 39,
                ),
                (financialsDividends.dividendPart.dividendCompanyName ==
                                null ||
                            financialsDividends
                                    .dividendPart.dividendCompanyName ==
                                'no data') &&
                        (financialsDividends
                                    .dividendPart.dividendYield.company ==
                                null ||
                            financialsDividends
                                    .dividendPart.dividendYield.company ==
                                'no data') &&
                        (financialsDividends
                                    .dividendPart.dividendYield.industry ==
                                null ||
                            financialsDividends
                                    .dividendPart.dividendYield.industry ==
                                'no data') &&
                        (financialsDividends.dividendPart.payoutRatio.company ==
                                null ||
                            financialsDividends
                                    .dividendPart.payoutRatio.company ==
                                'no data') &&
                        (financialsDividends
                                    .dividendPart.annualizedPayout.industry ==
                                null ||
                            financialsDividends
                                    .dividendPart.annualizedPayout.industry ==
                                'no data') &&
                        (financialsDividends.dividendPart
                                    .annualizedGrowthLast5Years.industry ==
                                null ||
                            financialsDividends.dividendPart
                                    .annualizedGrowthLast5Years.industry ==
                                'no data')
                    ? Expanded(child: NoDataAvailablePage())
                    : Container(
                        height: 220,
                        child: CustomTable(
                          headersTitle: [
                            "Title",
                            financialsDividends
                                .dividendPart.dividendCompanyName,
                            "Industry"
                          ],
                          totalColumns: 3,
                          itemCount: 4,
                          fixedColumnWidth: 0.45 * MediaQuery.of(context).size.width,
                          columnwidth: 0.23 * MediaQuery.of(context).size.width,
                          leftSideItemBuilder: (c, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(titles[i], style: bodyText2White60),
                            );
                          },
                          rightSideItemBuilder: (c, i) {
                            List<String> d = [];
                            i == 0
                                ? d.addAll([
                                    financialsDividends
                                        .dividendPart.dividendYield.company,
                                    financialsDividends
                                        .dividendPart.dividendYield.industry
                                  ])
                                : i == 1
                                    ? d.addAll([
                                        financialsDividends
                                            .dividendPart.payoutRatio.company,
                                        financialsDividends
                                            .dividendPart.payoutRatio.industry
                                      ])
                                    : i == 2
                                        ? d.addAll([
                                            financialsDividends.dividendPart
                                                .annualizedPayout.company,
                                            financialsDividends.dividendPart
                                                .annualizedPayout.industry
                                          ])
                                        : d.addAll([
                                            financialsDividends
                                                .dividendPart
                                                .annualizedGrowthLast5Years
                                                .company,
                                            financialsDividends
                                                .dividendPart
                                                .annualizedGrowthLast5Years
                                                .industry
                                          ]);
                            return DataTableItem(
                              upperPadding: 10,
                              data: d,
                            );
                          },
                        ),
                      ),
                if (financialsDividends
                        .dividendYieldPart.exDividendDate.length !=
                    0)
                  Text('Dividend (Yield)', style: subtitle1White),
                if (financialsDividends
                        .dividendYieldPart.exDividendDate.length !=
                    0)
                  SizedBox(
                    height: 26,
                  ),
                if (financialsDividends
                        .dividendYieldPart.exDividendDate.length !=
                    0)
                  Container(
                      height: 300,
                      child: Column(
                        children: [
                          TableBarWithDropDownTitle(
                            title1: "Ex-Dividend Date",
                            // isProfitLoss: true,
                            title2: financialsDividends
                                .dividendYieldPart.paymentDate[_s2],
                            title3: financialsDividends
                                .dividendYieldPart.paymentDate[_s1],
                            menu: financialsDividends
                                .dividendYieldPart.paymentDate,
                            currentRightIndex: _s1,
                            currentLeftIndex: _s2,
                            openLeft: _openLeft,
                            openRight: _openRight,
                          ),
                          TableItem(
                            isFinancial: true,
                            title: dividend[1],
                            value: financialsDividends
                                .dividendYieldPart.dividend[_s2],
                            remarks: financialsDividends
                                .dividendYieldPart.dividend[_s1],
                          ),
                          TableItem(
                            isFinancial: true,
                            title: dividend[0],
                            value: financialsDividends
                                .dividendYieldPart.dividend[_s2],
                            remarks: financialsDividends
                                .dividendYieldPart.dividend[_s1],
                          ),
                          TableItem(
                            isFinancial: true,
                            title: dividend[1],
                            value: financialsDividends
                                .dividendYieldPart.epsPayoutRatio[_s2],
                            remarks: financialsDividends
                                .dividendYieldPart.epsPayoutRatio[_s1],
                          ),
                          TableItem(
                            isFinancial: true,
                            title: dividend[2],
                            value:
                                financialsDividends.dividendYieldPart.type[_s2],
                            remarks:
                                financialsDividends.dividendYieldPart.type[_s1],
                          ),
                          TableItem(
                            isFinancial: true,
                            title: dividend[3],
                            value: financialsDividends
                                .dividendYieldPart.paymentDate[_s2],
                            remarks: financialsDividends
                                .dividendYieldPart.paymentDate[_s1],
                          ),
                          TableItem(
                            isFinancial: true,
                            title: dividend[4],
                            value: financialsDividends
                                .dividendYieldPart.dividendYieldPartYield[_s2],
                            remarks: financialsDividends
                                .dividendYieldPart.dividendYieldPartYield[_s1],
                          ),
                        ],
                      )

                      // CustomTable(
                      //     headersTitle: [
                      //       "Ex-Dividend Date",
                      //       ...financialsDividends.dividendYieldPart.exDividendDate
                      //     ],
                      //     totalColumns: financialsDividends
                      //             .dividendYieldPart.exDividendDate.length +
                      //         1,
                      //     itemCount: 5,
                      //     //scrollPhysics: NeverScrollableScrollPhysics(),
                      //     fixedColumnWidth: 0.36.sw,
                      //     columnwidth: 0.28.sw,
                      //     leftSideItemBuilder: (c, i) {
                      //       return Padding(
                      //         padding: const EdgeInsets.symmetric(vertical: 10),
                      //         child: Text(dividend[i], style: bodyText2White60),
                      //       );
                      //     },
                      //     rightSideChildren: [
                      //       DataTableItem(
                      //           upperPadding: 10,
                      //           data: List<String>.generate(
                      //               financialsDividends
                      //                   .dividendYieldPart.exDividendDate.length,
                      //               (index) => financialsDividends
                      //                   .dividendYieldPart.dividend[index])),
                      //       DataTableItem(
                      //           upperPadding: 10,
                      //           data: List<String>.generate(
                      //               financialsDividends
                      //                   .dividendYieldPart.exDividendDate.length,
                      //               (index) => financialsDividends
                      //                   .dividendYieldPart.epsPayoutRatio[index])),
                      //       DataTableItem(
                      //           upperPadding: 10,
                      //           data: List<String>.generate(
                      //               financialsDividends
                      //                   .dividendYieldPart.exDividendDate.length,
                      //               (index) => financialsDividends
                      //                   .dividendYieldPart.type[index])),
                      //       DataTableItem(
                      //           upperPadding: 10,
                      //           data: List<String>.generate(
                      //               financialsDividends
                      //                   .dividendYieldPart.exDividendDate.length,
                      //               (index) => financialsDividends
                      //                   .dividendYieldPart.paymentDate[index])),
                      //       DataTableItem(
                      //           upperPadding: 10,
                      //           data: List<String>.generate(
                      //               financialsDividends
                      //                   .dividendYieldPart.exDividendDate.length,
                      //               (index) => financialsDividends.dividendYieldPart
                      //                   .dividendYieldPartYield[index])),
                      //     ]),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
