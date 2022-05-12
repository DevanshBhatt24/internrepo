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

class CashFlow extends StatefulWidget {
  final FinancialsCashflow financialsCashflow;
  final String title;
  CashFlow({this.financialsCashflow, this.title});
  @override
  _CashFlowState createState() => _CashFlowState();
}

class _CashFlowState extends State<CashFlow> {
  static List<String> m20 = ['53530', '633', '53530', '53530', '633'];

  static List<String> m19 = ['31983', '630', '31983', '53530', '630'];
  static List<String> m18 = ['53530', '633', '53530', '53530', '633'];
  static List<String> m17 = ['53530', '633', '53530', '53530', '633'];
  static List<String> m16 = ['53530', '633', '53530', '53530', '633'];
  List<String> head = [
    'Operation Activities',
    'Investing Activities',
    'Financing Activities',
    'Others',
    // 'Net Cash Flow'
  ];
  final data1 = [m20, m19, m18, m17, m16];
  FinancialsCashflow financialsCashflow;
  @override
  void initState() {
    super.initState();
    financialsCashflow = widget.financialsCashflow;

    menu = financialsCashflow.consolidated.headings;
  }

  bool isRight = false;

  _openRight(List<String> newMenu, int i) {
    setState(() {
      menu = newMenu;
      _currentRightPanel = i;
      isRight = true;
    });
    _panelController.open();
  }

  List<String> menu = [];
  int _s1 = 1;
  int _s2 = 0;
  int _currentLeftPanel = 0;
  int _currentRightPanel = 0;

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
            preferredSize: Size.fromHeight(95),
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
                    "Cash Flows",
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
            child: Column(
              children: [
                SizedBox(height: 25),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  content: SizedBox(
                    height: 264,
                    child: TabBarView(
                      children: [
                        Container(
                          child:
                              financialsCashflow.consolidated.headings.length !=
                                      0
                                  ? _returns(financialsCashflow.consolidated)
                                  : NoDataAvailablePage(),
                        ),
                        Container(
                          child:
                              financialsCashflow.standalone.headings.length != 0
                                  ? _returns(financialsCashflow.standalone)
                                  : NoDataAvailablePage(),
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
    );
  }

  Widget text(String s) {
    return Container(
      alignment: Alignment.centerLeft,
      // height: 53,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(s, textAlign: TextAlign.left, style: bodyText2White60),
      ),
    );
  }

  Widget _returns(FinancialsCashflowConsolidated arr) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Container(
          height: 230,
          padding: EdgeInsets.only(left: 10),
          child: Column(children: [
            TableBarWithDropDownTitle(
              title1: "",
              isProfitLoss: true,
              title2: arr.headings[_s2],
              title3: arr.headings[_s1],
              menu: arr.headings,
              currentRightIndex: _s1,
              currentLeftIndex: _s2,
              openLeft: _openLeft,
              openRight: _openRight,
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: head[0],
              value: arr.operatingActivities[_s2],
              remarks: arr.operatingActivities[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: head[1],
              value: arr.investingActivities[_s2],
              remarks: arr.investingActivities[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: head[2],
              value: arr.financingActivities[_s2],
              remarks: arr.financingActivities[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: head[3],
              value: arr.others[_s2],
              remarks: arr.others[_s1],
            ),
          ]),

          // CustomTable(
          //   scrollPhysics: NeverScrollableScrollPhysics(),
          //   headersTitle: [
          //     "",
          //     ...arr.headings,
          //   ],
          //   fixedColumnWidth: 0.43.sw,
          //   columnwidth: 0.25.sw,
          //   totalColumns: arr.headings.length + 1,
          //   itemCount: head.length,
          //   leftSideItemBuilder: (c, i) {
          //     return text(head[i]);
          //   },
          //   rightSideItemBuilder: (c, i) {
          //     var d;
          //     if (i == 0) {
          //       d = arr.operatingActivities;
          //     } else if (i == 1) {
          //       d = arr.investingActivities;
          //     } else if (i == 2) {
          //       d = arr.financingActivities;
          //     } else if (i == 3) {
          //       d = arr.others;
          //     }
          //     return Center(
          //       child: Container(
          //         padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: List.generate(
          //             arr.headings.length,
          //             (index) => Container(
          //               width: 0.25.sw,
          //               child: Text(d[index],
          //                   textAlign: TextAlign.center, style: bodyText2White),
          //             ),
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ),
      ],
    );
  }
}
