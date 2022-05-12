import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/slidePanel.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/styles.dart';
import 'package:technical_ind/widgets/datagrid.dart';
import 'package:technical_ind/widgets/miss.dart';
import 'package:technical_ind/widgets/tableItem.dart';

import '../../../components/bullet_with_body.dart';

class BalancePage extends StatefulWidget {
  final FinancialsBalancesheet balancesheet;
  final String title;
  BalancePage({Key key, this.balancesheet, this.title}) : super(key: key);

  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  FinancialsBalancesheet balancesheet;
  @override
  void initState() {
    super.initState();
    balancesheet = widget.balancesheet;
    menu = balancesheet.consolidated.quarters;
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

  PanelController _panelController = PanelController();

  _openLeft(List<String> newMenu, int i) {
    setState(() {
      menu = newMenu;
      _currentLeftPanel = i;
      isRight = false;
    });
    _panelController.open();
  }

  List<String> menu = [];
  int _s1 = 1;
  int _s2 = 0;
  int _currentLeftPanel = 0;
  int _currentRightPanel = 0;

  List<String> m = [
    "Equities & Liabilities",
    "Share Capital",
    "Reserves & Surplus",
    "Current Liabilities",
    "Other Liabilities",
    "Total Liabilities",
    "Assets",
    "Fixed Assets",
    "Current Assets",
    "Other Assets",
    "Total Assets",
    "Other Info",
    "Contingent Liabilities",
  ];
  List<String> m1 = [
    '',
    '6339',
    '418244',
    '310183',
    '234146',
    '968912',
    '',
    '6339',
    '418244',
    '310183',
    '234146',
    '',
    '234146',
  ];
  _getColor(int a) {
    if (a > 0)
      return blue;
    else if (a < 0)
      return red;
    else
      return yellow;
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
                    "Balance Sheet",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
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
                SizedBox(height: 20),
                Center(
                  child: Text("Analysis",
                      textAlign: TextAlign.center, style: subtitle1White),
                ),
                SizedBox(height: 20),
                ...List.generate(
                  balancesheet.analysis.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: BulletWithBody(
                        balancesheet.analysis[index].header,
                        balancesheet.analysis[index].description,
                        _getColor(
                            (int.tryParse(balancesheet.analysis[index].dir) ??
                                0))),
                  ),
                ),
                balancesheet.consolidated.assets.currentAssets.length == 0
                    ? SizedBox()
                    : StickyHeader(
                        header: Material(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TabBar(
                              isScrollable: false,
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
                        content: balancesheet
                                    .consolidated.assets.currentAssets.length ==
                                0
                            ? SizedBox()
                            : SizedBox(
                                height: 580,
                                child: TabBarView(
                                  children: [
                                    section(balancesheet.consolidated),
                                    section(balancesheet.standalone),
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

  Padding section(FinancialsBalancesheetConsolidated data) {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 26),
        child: Column(
          children: [
            TableBarWithDropDownTitle(
              title1: "",
              isProfitLoss: true,
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
              title: m[0],
              value: "",
              remarks: "",
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[1],
              value: data.equitiesLiabilities.shareCapital[_s2],
              remarks: data.equitiesLiabilities.shareCapital[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[2],
              value: data.equitiesLiabilities.reservesSurplus[_s2],
              remarks: data.equitiesLiabilities.reservesSurplus[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[3],
              value: data.equitiesLiabilities.currentLiabilities[_s2],
              remarks: data.equitiesLiabilities.currentLiabilities[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[4],
              value: data.equitiesLiabilities.otherLiabilities[_s2],
              remarks: data.equitiesLiabilities.otherLiabilities[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[5],
              value: data.equitiesLiabilities.totalLiabilities[_s2],
              remarks: data.equitiesLiabilities.totalLiabilities[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              isTitle: true,
              title: m[6],
              value: "",
              remarks: "",
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[7],
              value: data.assets.fixedAssets[_s2],
              remarks: data.assets.fixedAssets[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[8],
              value: data.assets.currentAssets[_s2],
              remarks: data.assets.currentAssets[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[9],
              value: data.assets.otherAssets[_s2],
              remarks: data.assets.otherAssets[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[10],
              value: data.assets.totalAssets[_s2],
              remarks: data.assets.totalAssets[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              isTitle: true,
              title: m[11],
              value: "",
              remarks: "",
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[12],
              value: data.others.contingentLiabilities[_s2],
              remarks: data.others.contingentLiabilities[_s1],
            ),
          ],
        )

        // CustomTable(
        //   headersTitle: [
        //     "",
        //     ...data.quarters.length > 5
        //         ? data.quarters.sublist(0, 5)
        //         : data.quarters
        //   ],
        //   fixedColumnWidth: 170,
        //   columnwidth: 80,
        //   totalColumns: data.quarters.length < 5 ? data.quarters.length + 1 : 6,
        //   itemCount: 13,
        //   leftSideItemBuilder: (c, i) {
        //     return Container(
        //       height: (m1[i] != "") ? 38 : 45,
        //       // padding: const EdgeInsets.only(top: 6),
        //       child: Align(
        //         alignment: Alignment.centerLeft,
        //         child: Text(m[i],
        //             textAlign: TextAlign.left,
        //             style: (m1[i] != "") ? bodyText2White60 : subtitle1White),
        //       ),
        //     );
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
        //       data: data.equitiesLiabilities.shareCapital,
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: data.equitiesLiabilities.reservesSurplus,
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: data.equitiesLiabilities.currentLiabilities,
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: data.equitiesLiabilities.otherLiabilities,
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: data.equitiesLiabilities.totalLiabilities,
        //     ),
        //     DataTableItem(
        //       height: 45,
        //       data: data.quarters.length < 5
        //           ? List<String>.filled(data.quarters.length, "")
        //           : ["", "", "", "", ""],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: data.assets.fixedAssets,
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: data.assets.currentAssets,
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: data.assets.otherAssets,
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: data.assets.totalAssets,
        //     ),
        //     DataTableItem(
        //       height: 45,
        //       data: data.quarters.length < 5
        //           ? List<String>.filled(data.quarters.length, "")
        //           : ["", "", "", "", ""],
        //     ),
        //     DataTableItem(
        //       height: 38,
        //       data: data.others.contingentLiabilities,
        //     ),
        //   ],
        // ),
        );
  }
}
