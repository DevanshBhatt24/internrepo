import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/bullet_with_body.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/components/slidePanel.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/widgets/miss.dart';
import 'package:technical_ind/widgets/tableItem.dart';
import '../../../widgets/datagrid.dart';
import '../../../styles.dart';

class ProfitLossPage extends StatefulWidget {
  final FinancialsProfitLoss profitLoss;
  final String title;
  ProfitLossPage({Key key, this.profitLoss, this.title}) : super(key: key);

  @override
  _ProfitLossPageState createState() => _ProfitLossPageState();
}

class _ProfitLossPageState extends State<ProfitLossPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _controller = ScrollController();
  FinancialsProfitLoss profitLoss;
  List<List<String>> consolidated, standalone;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    profitLoss = widget.profitLoss;
    menu = profitLoss.consolidated.quarters;
  }

  List<String> m = [
    "Dividend & Dividend Percentage",
    "Equity Share Dividend",
    "Tax on Dividend",
    "Earnings per share",
    "Basic EPS (₹)",
    "Diluted EPS (₹)",
    "Expenses",
    "Cost of Materials Consumed",
    "Depreciation & Amortisation Expns",
    "Employee Benefit Expenses",
    "Exceptional Items",
    "Finance Costs",
    "Operating & Direct Expenses",
    "Other Expenses",
    "P/L before Excp, Extr Items & Tax",
    "P/L before Tax",
    "Total Expenses",
    "Income",
    "Revenue from operations (Gross)",
    "Less: Excise/Service Tax / Other Levies",
    "Revenue from operations (Net)",
    "Total Operating Revenues",
    "Other Income",
    "Total Revenue",
    "Other Additional Information",
    "TAX-EXPENSES CONTINUED OPERATIONS",
    // "Consolidated P/L after MI & Associates",
    "Current Tax",
    "Deferred Tax",
    "Less: MAT Credit Entitlement",
    // "Minority Interest",
    "Other Direct Taxes",
    "P/L after Tax & before extraordinary Items",
    "P/L for the period",
    "P/L from continuing operations",
    "Total Tax Expenses",
  ];

  List<String> m1 = [
    '',
    '0.00',
    '0.00',
    '',
    '37153.99',
    '37153.99',
    '',
    '37153.99',
    '37153.99',
    '37153.99',
    '37153.99',
    '37153.99',
    '37153.99',
    '37153.99',
    '37153.99',
    '37153.99',
    '37153.99',
    '',
    '37153.99',
    '37153.99',
    '37153.99',
    '37153.99',
    '37153.99',
    '37153.99',
    '',
    '',
    // '37153.99',
    '37153.99',
    '37153.99',
    '37153.99',
    // '37153.99',
    '37153.99',
    '37153.99',
    '37153.99',
    '37153.99',
    '37153.99',
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

  _openLeft(List<String> newMenu, int i) {
    setState(() {
      menu = newMenu;
      _currentLeftPanel = i;
      isRight = false;
    });
    _panelController.open();
  }

  // List<String> headerTitle = [
  //   "",
  //   "Mar 2019",
  //   "Mar 2018",
  //   "Mar 2017",
  //   "Mar 2016",
  // ];
  _getColor(int a) {
    if (a > 0)
      return blue;
    else if (a < 0)
      return red;
    else
      return yellow;
  }

  List<String> menu = [];
  int _s1 = 1;
  int _s2 = 0;
  int _currentLeftPanel = 0;
  int _currentRightPanel = 0;

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
                  title: Text("Profit & Loss", style: headline6),
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
                SizedBox(height: 28),
                ...List.generate(
                  profitLoss.analysis.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: BulletWithBody(
                        profitLoss.analysis[index].prefix,
                        profitLoss.analysis[index].suffix,
                        _getColor(
                            (int.tryParse(profitLoss.analysis[index].dir) ??
                                0))),
                  ),
                ),
                StickyHeader(
                  header: Material(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TabBar(
                        controller: _tabController,
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
                  content: SizedBox(
                    height: _tabController.index == 0
                        ? (profitLoss.consolidated.quarters.length > 0
                            ? 1500
                            : MediaQuery.of(context).size.height * 0.6)
                        : profitLoss.standalone.quarters.length > 0
                            ? 1500
                            : MediaQuery.of(context).size.height * 0.6,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        profitLoss.consolidated.quarters.length > 0
                            ? section(profitLoss.consolidated)
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: NoDataAvailablePage()),
                        profitLoss.standalone.quarters.length > 0
                            ? section(profitLoss.standalone)
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: NoDataAvailablePage())
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

  Padding section(FinancialsProfitLossConsolidated data) {
    // List<String> spaces = [];
    // int length = data.quarters.length;
    // for (int i = 0; i < length; i++) {
    //   spaces.add(" ");
    // }
    return Padding(
        // padding: const EdgeInsets.only(left: 16, right: 16, top: 26),
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
              value: data.dividendDividendPercentage.equityShareDividend[_s2],
              remarks: data.dividendDividendPercentage.equityShareDividend[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[2],
              value: data.dividendDividendPercentage.taxOnDividend[_s2],
              remarks: data.dividendDividendPercentage.taxOnDividend[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              isTitle: true,
              title: m[3],
              value: "",
              remarks: "",
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[4],
              value: data.earningsPerShare.basicEps[_s2],
              remarks: data.earningsPerShare.basicEps[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[5],
              value: data.earningsPerShare.dilutedEps[_s2],
              remarks: data.earningsPerShare.dilutedEps[_s1],
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
              value: data.expenses.costOfMaterialsConsumed[_s2],
              remarks: data.expenses.costOfMaterialsConsumed[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[8],
              value: data.expenses.depreciationAmortisation[_s2],
              remarks: data.expenses.depreciationAmortisation[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[9],
              value: data.expenses.employeeBenefitExpenses[_s2],
              remarks: data.expenses.employeeBenefitExpenses[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[10],
              value: data.expenses.exceptionalItems[_s2],
              remarks: data.expenses.exceptionalItems[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[11],
              value: data.expenses.financeCosts[_s2],
              remarks: data.expenses.financeCosts[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[12],
              value: data.expenses.operatingDirectExpenses[_s2],
              remarks: data.expenses.operatingDirectExpenses[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[13],
              value: data.expenses.otherExpenses[_s2],
              remarks: data.expenses.otherExpenses[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[14],
              value: data.expenses.plBeforeExcpExtr[_s2],
              remarks: data.expenses.plBeforeExcpExtr[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[15],
              value: data.expenses.plBeforeTax[_s2],
              remarks: data.expenses.plBeforeTax[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[16],
              value: data.expenses.totalExpenses[_s2],
              remarks: data.expenses.totalExpenses[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              isTitle: true,
              title: m[17],
              value: "",
              remarks: "",
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[18],
              value: data.income.revenueFromOperationsGross[_s2],
              remarks: data.income.revenueFromOperationsGross[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[19],
              value: data.income.lessExciseStOl[_s2],
              remarks: data.income.lessExciseStOl[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[20],
              value: data.income.revenueFromOperationsNet[_s2],
              remarks: data.income.revenueFromOperationsNet[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[21],
              value: data.income.totalOperatingRevenue[_s2],
              remarks: data.income.totalRevenue[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[22],
              value: data.income.otherIncome[_s2],
              remarks: data.income.otherIncome[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[23],
              value: data.income.totalRevenue[_s2],
              remarks: data.income.totalRevenue[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              isTitle: true,
              title: m[24],
              value: "",
              remarks: "",
            ),
            TableItem(
              isFinancial: true,
              isTitle: true,
              isProfitLoss: true,
              title: m[25],
              value: "",
              remarks: "",
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[26],
              value: data.taxExpensesContinued.currentTax[_s2],
              remarks: data.taxExpensesContinued.currentTax[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[27],
              value: data.taxExpensesContinued.deferredTax[_s2],
              remarks: data.taxExpensesContinued.deferredTax[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[28],
              value: data.taxExpensesContinued.lessMatCreditEntitlement[_s2],
              remarks: data.taxExpensesContinued.lessMatCreditEntitlement[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[29],
              value: data.taxExpensesContinued.otherDirectTaxes[_s2],
              remarks: data.taxExpensesContinued.otherDirectTaxes[_s1],
            ),
            TableItem(
              isFinancial: true,
              isProfitLoss: true,
              title: m[30],
              value: data.taxExpensesContinued.plAfterTaxBeforeExtraItems[_s2],
              remarks:
                  data.taxExpensesContinued.plAfterTaxBeforeExtraItems[_s1],
            ),
          ],
        )
        // CustomTable(
        //   horizontalScrollController: _controller,
        //   headersTitle: ["", ...data.quarters],
        //   fixedColumnWidth: 170,
        //   columnwidth: 80,
        //   totalColumns: 1 + length,
        //   itemCount: m.length,
        //   leftSideItemBuilder: (c, i) {
        //     return Container(
        //       height: (m1[i] != "") ? 48 : 45,
        //       // padding: const EdgeInsets.only(top: 6),
        //       child: Align(
        //         alignment: Alignment.centerLeft,
        //         child: Text(
        //           m[i],
        //           textAlign: TextAlign.left,
        //           style: (m1[i] != "") ? bodyText2White60 : subtitle1White,
        //         ),
        //       ),
        //     );
        //   },
        //   rightSideChildren: [
        //     DataTableItem(
        //       height: 45,
        //       data: spaces,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.dividendDividendPercentage.equityShareDividend,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.dividendDividendPercentage.taxOnDividend,
        //     ),
        //     DataTableItem(
        //       height: 45,
        //       data: spaces,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.earningsPerShare.basicEps,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.earningsPerShare.dilutedEps,
        //     ),
        //     DataTableItem(
        //       height: 45,
        //       data: spaces,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.expenses.costOfMaterialsConsumed,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.expenses.depreciationAmortisation,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.expenses.employeeBenefitExpenses,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.expenses.exceptionalItems,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.expenses.financeCosts,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.expenses.operatingDirectExpenses,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.expenses.otherExpenses,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.expenses.plBeforeExcpExtr,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.expenses.plBeforeTax,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.expenses.totalExpenses,
        //     ),
        //     DataTableItem(
        //       height: 45,
        //       data: spaces,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.income.revenueFromOperationsGross,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.income.lessExciseStOl,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.income.revenueFromOperationsNet,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.income.totalOperatingRevenue,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.income.otherIncome,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.income.totalRevenue,
        //     ),
        //     DataTableItem(
        //       height: 45,
        //       data: spaces,
        //     ),
        //     DataTableItem(
        //       height: 45,
        //       data: spaces,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.taxExpensesContinued.currentTax,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.taxExpensesContinued.deferredTax,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.taxExpensesContinued.lessMatCreditEntitlement,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.taxExpensesContinued.otherDirectTaxes,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.taxExpensesContinued.plAfterTaxBeforeExtraItems,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.taxExpensesContinued.plForThePeriod,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.taxExpensesContinued.plFromContinuingOperations,
        //     ),
        //     DataTableItem(
        //       height: 48,
        //       data: data.taxExpensesContinued.totalTaxExpenses,
        //     ),
        //   ],
        // ),
        );
  }
}
