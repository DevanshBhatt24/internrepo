import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';

import '../../../components/bullet_colored.dart';
import '../../../styles.dart';
import '../explore/riskProfilePage.dart';
import 'balancePage.dart';
import 'capitalStructurePage.dart';
import 'cashFlow.dart';
import 'dividendPage.dart';
import 'earningPage.dart';
import 'incomeStatement.dart';
import 'profitLossPAge.dart';
import 'ratios.dart';
import 'solvencyPage.dart';

Widget customAppBar({BuildContext context, String title, String subtitle}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(91),
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
          title: Text(title, style: headline6),
        ),
        SizedBox(height: 12),
        Center(
          child: Text(subtitle,
              textAlign: TextAlign.center, style: subtitle1White),
        )
      ],
    ),
  );
}

class CustomListTile extends StatelessWidget {
  final String title;
  final Function onTap;

  const CustomListTile({Key key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(bottom: 14, top: 14, right: 5),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title, style: subtitle1White),
          Icon(
            CupertinoIcons.forward,
            color: white60,
          )
        ]),
      ),
    );
  }
}

class FinancialPage extends StatefulWidget {
  final String isin;

  final String title;
  FinancialPage({
    Key key,
    this.isin,
    this.title,
  }) : super(key: key);

  @override
  _FinancialPageState createState() => _FinancialPageState();
}

class _FinancialPageState extends State<FinancialPage> {
  FinancialsIncomeStatement financialsIncomeStatement;
  FinancialsProfitLoss profitLoss;
  FinancialsBalancesheet balancesheet;
  FinancialsRatios ratios;
  FinancialsRiskProfile financialsRiskProfile;
  FinancialsSolvency financialsSolvency;
  FinancialsDividends financialsDividends;
  FinancialsEarnings financialsEarnings;
  String title;
  FinancialsCashflow financialsCashflow;
  var response;
  bool loading = true;
  fetchApi() async {
    response = await StockServices.stockFinancialDetails(widget.isin);
    financialsIncomeStatement = FinancialsIncomeStatement.fromJson(
        response['financials_income_statement']);
    profitLoss =
        FinancialsProfitLoss.fromJson(response['financials_profit_loss']);
    balancesheet =
        FinancialsBalancesheet.fromJson(response['financials_balancesheet']);
    ratios = FinancialsRatios.fromJson(response['financials_ratios']);
    financialsRiskProfile =
        FinancialsRiskProfile.fromJson(response['financials_risk_profile']);
    financialsSolvency =
        FinancialsSolvency.fromJson(response['financials_solvency']);
    financialsDividends =
        FinancialsDividends.fromJson(response['financials_dividends']);
    financialsEarnings =
        FinancialsEarnings.fromJson(response['financials_earnings']);
    financialsCashflow =
        FinancialsCashflow.fromJson(response['financials_cashflow']);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    title = widget.title;
    fetchApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : (financialsIncomeStatement == null ||
                profitLoss == null ||
                balancesheet == null ||
                ratios == null ||
                financialsRiskProfile == null ||
                financialsSolvency == null ||
                financialsDividends == null ||
                financialsEarnings == null ||
                financialsCashflow == null)
            ? NoDataAvailablePage()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      // Text('Analysis', style: subtitle1White),
                      // SizedBox(height: 16),
                      // BulletColored('Positive', blue),
                      // _text('Near term Operating Profit trend is positive'),
                      // _text('Near term PBT trend is positive'),
                      // _text('Near term PAT trend is positive'),
                      // _text(
                      //     'Increasing profitability, company has created higher earnings for shareholders'),
                      // SizedBox(height: 8),
                      // BulletColored('Negative', red),
                      // _text('Near term Operating Profit trend is negative'),
                      // _text('Near term PBT trend is negative'),
                      // _text('Near term PAT trend is negative'),
                      // _text(
                      //     'Decreasing profitability, company has created lower earnings for shareholders'),
                      // SizedBox(height: 30),
                      Container(
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            CustomListTile(
                              title: "Income Statement",
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => IncomeStatement(
                                          financialsIncomeStatement:
                                              financialsIncomeStatement,
                                          title: widget.title ?? "",
                                        )));
                              },
                            ),
                            CustomListTile(
                              title: "Profit & Loss",
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProfitLossPage(
                                          profitLoss: profitLoss,
                                          title: widget.title ?? "",
                                        )));
                              },
                            ),
                            CustomListTile(
                              title: "Balance Sheet",
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BalancePage(
                                          balancesheet: balancesheet,
                                          title: title ?? "",
                                        )));
                              },
                            ),
                            CustomListTile(
                              title: "Cashflow",
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CashFlow(
                                          financialsCashflow:
                                              financialsCashflow,
                                          title: title ?? "",
                                        )));
                              },
                            ),
                            CustomListTile(
                              title: "Ratios",
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Ratios(
                                          ratios: ratios,
                                          title: widget.title ?? "",
                                        )));
                              },
                            ),
                            // CustomListTile(
                            //   title: "Capital Structure",
                            //   onTap: () {
                            //     Navigator.of(context).push(MaterialPageRoute(
                            //         builder: (context) => CapitalStructure()));
                            //   },
                            // ),
                            CustomListTile(
                              title: "Earnings",
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EarningPage(
                                          financialsEarnings:
                                              financialsEarnings,
                                          title: title ?? "",
                                        )));
                              },
                            ),
                            CustomListTile(
                              title: "Dividend",
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DividendPage(
                                          financialsDividends:
                                              financialsDividends,
                                          title: title ?? "",
                                        )));
                              },
                            ),
                            // CustomListTile(
                            //   title: "Solvency",
                            //   onTap: () {
                            //     Navigator.of(context).push(MaterialPageRoute(
                            //         builder: (context) => SolvencyPage(
                            //               financialsSolvency:
                            //                   financialsSolvency,
                            //               title: title ?? "",
                            //             )));
                            //   },
                            // ),
                            // CustomListTile(
                            //   title: "Risk Profile",
                            //   onTap: () {
                            //     Navigator.of(context).push(MaterialPageRoute(
                            //         builder: (context) => RiskProfilePage(
                            //               financialsRiskProfile:
                            //                   financialsRiskProfile,
                            //               title: title ?? "",
                            //             )));
                            //   },
                            // ),
                            SizedBox(
                              height: 50,
                            ),
                            Center(
                                child: Text(
                              "All figures are in Cr.",
                              style: subtitle1White.copyWith(fontSize: 16),
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }

  Widget _text(String s) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, top: 2, bottom: 6, right: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
                  child: Text(
            s,
            style: bodyText2White60,
            textAlign: TextAlign.left,
          ))),
        ],
      ),
    );
  }
}
