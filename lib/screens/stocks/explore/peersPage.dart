import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/screens/stocks/business/models/peers.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';
import 'package:technical_ind/screens/stocks/explore/fAndO.dart';
import 'package:technical_ind/screens/stocks/explore/home.dart';
import 'package:technical_ind/styles.dart';
import 'package:technical_ind/widgets/miss.dart';

class PeersPage extends StatefulWidget {
  final String isin;
  const PeersPage({Key key, this.isin}) : super(key: key);

  @override
  _PeersPageState createState() => _PeersPageState();
}

class _PeersPageState extends State<PeersPage> {
  List<Peers> peers;
  bool loading = true;
  FutureAndOptions futureAndOptions;
  fetchApi() async {
    peers = await StockServices.getPeers(widget.isin);
    setState(() {
      loading = false;
    });
    _refreshController.refreshCompleted();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : peers == null
            ? NoDataAvailablePage()
            : Scaffold(
                body: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: _refreshController,
                  onRefresh: fetchApi,
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
                  child: ListView.builder(
                      itemCount: peers.length,
                      itemBuilder: (context, index) {
                        var peer = peers[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 5),
                          child: InkWell(
                            onTap: () {
                              pushNewScreen(context,
                                  screen: Homepage(
                                    isin: peer.stockCode,
                                  ));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  TableBarv2(
                                    title1: peer.companyName ?? '-',
                                    title2: '',
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 12),
                                  TableItemv2(
                                    title: 'PRICE',
                                    value: peer.price ?? '-',
                                  ),
                                  TableItemv2(
                                    title: 'Mcap(cr)',
                                    value: peer.mCapCr ?? '-',
                                  ),
                                  TableItemv2(
                                    title: 'TTM PE',
                                    value: peer.tTMPE ?? '-',
                                  ),
                                  TableItemv2(
                                    title: 'P/B',
                                    value: peer.pB ?? '-',
                                  ),

                                  TableItemv2(
                                    title: 'Change(%)',
                                    value: peer.chgPercent[0].contains('-')
                                        ? peer.chgPercent
                                        : '+' + peer.chgPercent ?? '-',
                                    valueColor: peer.chgPercent[0].contains('-')
                                        ? red
                                        : blue,
                                  ),
                                  TableItemv2(
                                    title: 'ROE',
                                    value: peer.rOE ?? '-',
                                  ),
                                  TableItemv2(
                                    title: '1 Yr Perform',
                                    value: peer.oneYrPerform ?? '-',
                                  ),
                                  TableItemv2(
                                    title: 'Net Profit',
                                    value: peer.netProfit ?? '-',
                                  ),
                                  TableItemv2(
                                    title: 'Net Sales',
                                    value: peer.netSales ?? '-',
                                  ),
                                  TableItemv2(
                                    title: 'Debt to Equity',
                                    value: peer.debtToEquity ?? '-',
                                  ),
                                  // SizedBox(height: 26),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              );
  }
}
