import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/styles.dart';
import 'package:technical_ind/widgets/datagrid.dart';
import 'package:technical_ind/widgets/item.dart';
import 'package:technical_ind/widgets/miss.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'financialPage.dart';

class EarningPage extends StatefulWidget {
  final FinancialsEarnings financialsEarnings;
  final String title;
  EarningPage({Key key, this.financialsEarnings, this.title}) : super(key: key);

  @override
  _EarningPageState createState() => _EarningPageState();
}

class _EarningPageState extends State<EarningPage> {
  FinancialsEarnings financialsEarnings;
  @override
  void initState() {
    super.initState();
    financialsEarnings = widget.financialsEarnings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "Earnings", subtitle: widget.title, context: context),
      body: financialsEarnings.earningsTableData.length == 0 &&
              financialsEarnings.latestRelease == 'no data' &&
              financialsEarnings.epsForecast == 'no data' &&
              financialsEarnings.revenueForecast == 'no data'
          ? NoDataAvailablePage()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TableItemv2(
                        title: "Latest Release",
                        value: financialsEarnings.latestRelease),
                    TableItemv2(
                      title: "EPS / Forecast",
                      value: financialsEarnings.epsForecast,
                      valueColor: financialsEarnings.epsForecast.contains('--')
                          ? white
                          : double.parse(financialsEarnings.epsForecast
                                      .split('/')[0]) >=
                                  double.parse(financialsEarnings.epsForecast
                                      .split('/')[1])
                              ? blue
                              : red,
                    ),
                    TableItemv2(
                      title: "Revenue / Forecast",
                      value: financialsEarnings.revenueForecast,
                      valueColor:
                          financialsEarnings.revenueForecast.contains('--')
                              ? white
                              : double.parse(financialsEarnings.revenueForecast
                                          .split('/')[0]
                                          .split('B')[0]) >=
                                      double.parse(financialsEarnings
                                          .revenueForecast
                                          .split('/')[1]
                                          .split('B')[0])
                                  ? blue
                                  : red,
                    ),

                    // ),
                    SizedBox(height: 24),
                    financialsEarnings.earningsTableData.length == 0
                        ? NoDataAvailablePage()
                        : _tableBuilder2(financialsEarnings)
                  ],
                ),
              ),
            ),
    );
  }

  _tableBuilder2(FinancialsEarnings list) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              TableBarv2(
                title1: list.earningsTableData[i].date ?? '-',
                title2: '',
                color: Colors.white,
              ),
              SizedBox(height: 12),
              TableItemv2(
                title: 'Period End',
                value: list.earningsTableData[i].periodEnd ?? '-',
              ),
              TableItemv2(
                title: 'EPS/Forecast',
                value: list.earningsTableData[i].epsForecast ?? '-',
              ),
              TableItemv2(
                title: 'Revenue',
                value: list.earningsTableData[i].revenueForecast ?? '-',
              ),

              // SizedBox(height: 26),
            ],
          ),
        );
      },
      itemCount: list.earningsTableData.length,
    );
  }
}
