import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/cryptocurrency/business/crypto_services.dart';
import 'package:technical_ind/screens/etf/business/etf_services.dart';
import 'package:technical_ind/screens/forex/business/services.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';
import 'package:technical_ind/widgets/miss.dart';
import 'package:technical_ind/widgets/tableItem.dart';
import 'business/crypto_overview_model.dart';
import '../../styles.dart';
import '../../widgets/datagrid.dart';

class HistoryPage extends StatefulWidget {
  final String isin;
  final bool isStock, isEtf;
  final bool isForex;
  final bool isCrypto;
  final HistoricalData historicalData;
  final double columnWidth;
  HistoryPage(
      {Key key,
      this.isStock = false,
      this.isForex = false,
      this.isCrypto = false,
      this.isEtf = false,
      this.isin,
      this.historicalData,
      this.columnWidth})
      : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  HistoricalData arr;
  ScrollController horizontalScrollcontroller1 = ScrollController();
  ScrollController horizontalScrollcontroller2 = ScrollController();
  ScrollController horizontalScrollcontroller3 = ScrollController();
  bool loading = true;

  _fetchApi() async {
    if (widget.isStock) {
      arr = await StockServices.stockHistoricalDataDetails(widget.isin);
    } else if (widget.isForex) {
      arr = await ForexServices.getForexHistoricalData(widget.isin);
    } else if (widget.isEtf) {
      arr = await EtfServices.getHistoricalDataDetails(widget.isin);
    } else {
      arr = await CryptoServices.getCryptoHistoricalData(widget.isin);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : arr != null
            ? DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: TabBar(
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
                        text: "Daily",
                      ),
                      Tab(
                        text: "Weekly",
                        //child: NSEtab(),
                      ),
                      Tab(
                        text: "Monthly",
                        //child: NSEtab(),
                      ),
                    ],
                  ),
                  body: TabBarView(
                    children: [
                      // _historyBuilder(arr.daily, horizontalScrollcontroller1),
                      arr?.daily == null
                          ? SizedBox()
                          : _historyBuilder2(arr?.daily),
                      arr?.weekly == null
                          ? SizedBox()
                          : _historyBuilder2(arr?.weekly),
                      arr?.monthly == null
                          ? SizedBox()
                          : _historyBuilder2(arr?.monthly),
                    ],
                  ),
                ),
              )
            : NoDataAvailablePage();
  }

  _historyBuilder2(List<Daily> list) {
    return ListView.builder(
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Column(
            children: [
              TableBarv2(
                title1: list[i]?.date ?? '-',
                title2: '',
                color: Colors.white,
              ),
              SizedBox(height: 12),
              TableItemv2(
                title: 'PRICE',
                value: list[i]?.price ?? '-',
              ),
              TableItemv2(
                title: 'OPEN',
                value: list[i]?.open ?? '-',
              ),
              TableItemv2(
                title: 'HIGH',
                value: list[i]?.high ?? '-',
              ),
              TableItemv2(
                title: 'LOW',
                value: list[i]?.low ?? '-',
              ),
              TableItemv2(
                title: 'VOL',
                value: list[i]?.volume ?? '-',
              ),
              TableItemv2(
                title: 'CHG %',
                value: list[i]?.chgPercent[0] == '-'
                    ? list[i]?.chgPercent
                    : '+' + list[i]?.chgPercent ?? '-',
                valueColor: list[i]?.chgPercent[0] == '-' ? red : blue,
              ),
              // SizedBox(height: 26),
            ],
          ),
        );
      },
      itemCount: list.length,
    );
  }
}
