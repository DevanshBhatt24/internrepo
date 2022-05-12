import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/indices/business/indices_services.dart';

import '../../../components/cardFinal.dart';
import '../../../styles.dart';
import '../../../widgets/item.dart';
import '../business/indices_forex_model.dart';

class ForexIndices extends StatefulWidget {
  ForexIndices();
  @override
  _ForexIndicesState createState() => _ForexIndicesState();
}

class _ForexIndicesState extends State<ForexIndices> {
  var crossAxisCount;
  IndicesForexModel indicesForexModel;
  bool loading = true;
  _fetchApi() async {
    indicesForexModel = await IndicesServices.getForexList();
    setState(() {
      loading = false;
    });
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    _fetchApi();
    // Timer.periodic(Duration(milliseconds: autoRefreshDuration), (t) {
    //   if (mounted)
    //     _fetchApi();
    //   else {
    //     print("Timer Ticking is stopping.");
    //     t.cancel();
    //   }
    // });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? LoadingPage()
          : indicesForexModel == null
              ? NoDataAvailablePage()
              : Padding(
                  padding:
                      EdgeInsets.only(top: 18, left: 16, right: 16, bottom: 55),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 600)
                        crossAxisCount = 2;
                      else {
                        crossAxisCount = 4;
                      }
                      return SmartRefresher(
                        controller: _refreshController,
                        enablePullDown: true,
                        enablePullUp: false,
                        header: ClassicHeader(
                          completeIcon: Icon(Icons.done, color: Colors.white60),
                          refreshingIcon: SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              color: Colors.white60,
                            ),
                          ),
                        ),
                        onRefresh: () => _fetchApi(),
                        child: GridView.count(
                          childAspectRatio: 0.93,
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          children: List.generate(
                            indicesForexModel.data.length,
                            (index) => section(
                              context,
                              indicesForexModel?.data[index].name ?? "",
                              indicesForexModel?.data[index].price ?? "",
                              indicesForexModel?.data[index].chg ?? "",
                              indicesForexModel?.data[index].datumChg ?? "",
                              indicesForexModel?.data[index].fullName ?? "",
                              indicesForexModel?.data[index].high ?? "",
                              indicesForexModel?.data[index].low ?? "",
                              indicesForexModel?.data[index].symbol ?? "",
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  InkWell section(BuildContext context, String name, String price, String chg,
      String chrpercent, String currency, String high, String low, String url) {
    return InkWell(
        onTap: () {
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => OverviewForexIndices()));
        },
        child: CardGridItem(
          title: name,
          isGlobal: true,
          value: price,
          subvalue: chg[0] != '-'
              ? '+' + chg + ' (+' + chrpercent + ')'
              : chg + ' (' + chrpercent + ')',
          color: chg[0] == '-' ? red : blue,
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 11,
                width: 20,
                child: Image.asset(
                  'icons/flags/png/${url.toString().substring(47, 49).toLowerCase()}.png',
                  package: 'country_icons',
                ),
              ),
              Container(
                child: Text(
                  "  " + currency.replaceAll("Currency Index", ""),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.2,
                    color: white60,
                  ),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
              )
            ],
          ),
          items: [
            RowItem("High", high, pad: 3),
            RowItem("Low", low, pad: 3),
          ],
        ));
  }
}
