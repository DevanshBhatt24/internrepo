import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/slidePanel.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/widgets/miss.dart';
import 'package:technical_ind/widgets/tableItem.dart';
import '../../../components/bullet_with_body.dart';
import '../../../styles.dart';

class IncomeStatement extends StatefulWidget {
  final FinancialsIncomeStatement financialsIncomeStatement;
  final String title;

  const IncomeStatement({Key key, this.financialsIncomeStatement, this.title})
      : super(key: key);
  @override
  _IncomeStatementState createState() => _IncomeStatementState();
}

class _IncomeStatementState extends State<IncomeStatement> {
  FinancialsIncomeStatement income;
  @override
  void initState() {
    super.initState();
    income = widget.financialsIncomeStatement;
    menu = income.consolidated.quarterlyReturns.quarters;
  }

  List<String> head = [
    'Sales',
    'Other Income',
    'Total Expenditure',
    'EBIT',
    'Interest',
    'Tax',
    'Net Profit'
  ];
  List<String> heading = [
    'Quarterly Returns',
    'Half Yearly Returns',
    'Nine Monthly Returns',
    'Annual Returns'
  ];
  _getColor(int a) {
    if (a > 0)
      return blue;
    else if (a < 0)
      return red;
    else
      return yellow;
  }

  PanelController _panelController = PanelController();

  bool isRight = false;

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

  List<String> menu = [];
  List<int> _s1 = [1, 1, 1, 1];
  List<int> _s2 = [0, 0, 0, 0];
  int _currentLeftPanel = 0;
  int _currentRightPanel = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SlidePanel(
        menu: menu,
        defaultWidget: isRight
            ? menu[_s1[_currentRightPanel]]
            : menu[_s2[_currentLeftPanel]],
        onChange: (val) {
          setState(() {
            isRight
                ? _s1[_currentRightPanel] = val
                : _s2[_currentLeftPanel] = val;
          });
        },
        panelController: _panelController,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(84),
            child: Column(
              children: [
                AppBar(backgroundColor: Colors.black,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(CupertinoIcons.back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  title: Text(
                    "Income Statement",
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 25),
                  Center(
                    child: Text("Analysis",
                        textAlign: TextAlign.center, style: subtitle1White),
                  ),
                  SizedBox(height: 16),
                  ...List.generate(
                    income.analysis.length,
                    (index) => BulletWithBody(
                        income.analysis[index].prefix,
                        income.analysis[index].suffix,
                        _getColor(
                            (int.tryParse(income.analysis[index].dir) ?? 0))),
                  ),
                  SizedBox(height: 5),
                  income.consolidated.halfyearlyReturns.ebit.length == 0
                      ? SizedBox()
                      : StickyHeader(
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
                            margin: EdgeInsets.only(top: 20),
                            height: 1940,
                            child: income.consolidated.halfyearlyReturns.ebit
                                        .length ==
                                    0
                                ? SizedBox()
                                : TabBarView(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: ListView.builder(
                                          itemBuilder: (ctx, index) {
                                            return _returns(
                                                index, income.consolidated);
                                          },
                                          itemCount: 4,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: ListView.builder(
                                            itemBuilder: (ctx, index) {
                                              return _returns(
                                                  index, income.standalone);
                                            },
                                            itemCount: 4,
                                            physics:
                                                NeverScrollableScrollPhysics()),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget text(String s) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 0.025 * MediaQuery.of(context).size.height),
        child: Text(s, textAlign: TextAlign.left, style: bodyText2White60),
      ),
    );
  }

  Widget _returns(int i, FinancialsIncomeStatementConsolidated data) {
    var d = i == 0
        ? data.quarterlyReturns
        : i == 1
            ? data.halfyearlyReturns
            : i == 2
                ? data.ninemonthsReturns
                : data.yearlyReturns;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(heading[i],
                  textAlign: TextAlign.left, style: subtitle1White),
              SizedBox(height: 22),
              TableBarWithDropDownTitle(
                  title1: "",
                  title2: d.quarters[_s2[i]],
                  title3: d.quarters[_s1[i]],
                  menu: d.quarters,
                  currentRightIndex: i,
                  currentLeftIndex: i,
                  openRight: _openRight,
                  openLeft: _openLeft),
              Column(
                  children: List.generate(
                head.length,
                // _s1 == 0
                //     ? selectedTimeObject
                //         .movingAverages
                //         .tableData
                //         .exponential
                //         .length
                //     : selectedTimeObject
                //         .movingAverages
                //         .tableData
                //         .simple
                //         .length,
                (j) {
                  var dd = j == 0
                      ? d.sales
                      : j == 1
                          ? d.otherIncome
                          : j == 2
                              ? d.totalExpenditure
                              : j == 3
                                  ? d.ebit
                                  : j == 4
                                      ? d.interest
                                      : j == 5
                                          ? d.tax
                                          : d.netProfit;
                  return TableItem(
                    isFinancial: true,
                    title: head[j],
                    value: dd[_s2[i]],
                    remarks: dd[_s1[i]],
                  );
                },
              )),
              SizedBox(height: 22),
            ]));
    // Column(
    //   mainAxisSize: MainAxisSize.min,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     // SizedBox(height: 18),
    //     Text(heading[i], textAlign: TextAlign.left, style: subtitle1White),
    //     SizedBox(height: 22),
    //     Container(
    //       height: 420,
    //       child: CustomTable(
    //         scrollPhysics: NeverScrollableScrollPhysics(),
    //         headersTitle: ["", ...d.quarters],
    //         fixedColumnWidth: 0.34.sw,
    //         columnwidth: 0.25.sw,
    //         totalColumns: 6,
    //         itemCount: head.length,
    //         leftSideItemBuilder: (c, j) {
    //           return text(head[j]);
    //         },
    //         rightSideItemBuilder: (c, j) {
    //           var dd = j == 0
    //               ? d.sales
    //               : j == 1
    //                   ? d.otherIncome
    //                   : j == 2
    //                       ? d.totalExpenditure
    //                       : j == 3
    //                           ? d.ebit
    //                           : j == 4
    //                               ? d.interest
    //                               : j == 5
    //                                   ? d.tax
    //                                   : d.netProfit;
    //           return Center(
    //             child: Container(
    //               padding: EdgeInsets.symmetric(
    //                 horizontal: 0,
    //                 vertical: 0.025 * MediaQuery.of(context).size.height,
    //               ),
    //               child: Row(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: List.generate(
    //                       dd.length,
    //                       (index) => Container(
    //                             width: 0.25.sw,
    //                             child: Text(dd[index] != "" ? dd[index] : "-",
    //                                 textAlign: TextAlign.center,
    //                                 style: bodyText2White),
    //                           ))),
    //             ),
    //           );
    //         },
    //       ),
    //     ),
    //     SizedBox(height: 22),
    //   ],
    // );
  }
}
