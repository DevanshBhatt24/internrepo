import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/screens/cryptocurrency/business/crypto_list_model.dart';
import 'package:technical_ind/screens/etf/business/eftlist_model.dart';
import 'package:technical_ind/screens/etf/business/etf_services.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_ind/widgets/item.dart';
import 'business/crypto_services.dart';
import 'business/crypto_overview_model.dart';

import '../../styles.dart';

class OverviewPage extends StatefulWidget {
  final String value, subvalue, price, chng, chngPercentage;
  final String query;
  final bool isEtf;
  OverviewPage({
    Key key,
    this.price,
    this.chng,
    this.chngPercentage,
    this.query,
    this.isEtf = false,
    this.subvalue,
    this.value,
  }) : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  Overview arr;
  EtfOverviewModel etfArr;
  bool loading = true;
  fetchApi() async {
    if (widget.isEtf) {
      etfArr = await EtfServices.getEtfOverview(widget.query);
    } else {
      arr = await CryptoServices.getCryptoOverviewData(widget.query);
    }
    setState(() {
      loading = false;
    });
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    // TODO: implement dispose

    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> _list = !widget.isEtf
        ? [
            "Previous Close",
            "Open",
            "Day's Range",
            "52 Week Range",
            "Start date",
            "Algorithm",
            "Market Cap (₹)",
            "Circulating Supply (₹)",
            "Max Supply (₹)",
            "Volume (₹)",
            "Volume (24 hrs) (₹)",
            "Volume (24 hrs) all currencies (₹)",
          ]
        : [
            "Open",
            "High",
            "Low",
            "Volume",
            "Previous Close",
            "Average Volume",
            "One Year Change",
            "Week Range",
            "Rating",
            "Risk Rating",
            "Asset Class",
            "Issuer",
            "Inception Date",
          ];
    List<String> values = arr != null
        ? [
            arr.previousClose ?? "",
            arr.openAt ?? "",
            arr.daysRange ?? "",
            arr.weekRange ?? "",
            arr.startDate?.toString()?.substring(0, 10) ?? "",
            arr.algorithm ?? "",
            arr.marketCapture ?? "",
            arr.circulatingSupply ?? "",
            arr.maxSupply ?? "",
            arr.volume ?? "",
            arr.volume24Hrs ?? "",
            arr.volume24HrsAllCurrencies ?? "",
          ]
        : ['', '', '', '', '', '', '', '', '', '', '', ''];

    List<String> etfValues = etfArr != null
        ? [
            etfArr?.openValue,
            etfArr?.high,
            etfArr?.low,
            etfArr?.volume,
            etfArr?.prevClose,
            etfArr?.avgVol,
            etfArr?.oneYearChg,
            etfArr?.weekRange,
            etfArr?.rating,
            etfArr?.riskRating,
            etfArr?.assetClass,
            etfArr?.issuer,
            etfArr?.inceptionDate,
          ]
        : ['', '', '', '', '', '', '', '', '', '', '', ''];
    return loading
        ? LoadingPage()
        : arr == null && etfArr == null
            ? NoDataAvailablePage()
            : SmartRefresher(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: 32),
                      if (widget.isEtf == false) ...[
                        Center(
                            child: Text(widget.value, style: headline5White)),
                        Center(
                          child: Text(
                            widget.subvalue,
                            style: subtitle2.copyWith(
                              color: widget.subvalue[0] == '-' ? red : blue,
                            ),
                          ),
                        ),
                      ],
                      if (widget.isEtf) ...[
                        Center(
                            child: Text(widget.price,
                                // etfArr?.price ?? "",
                                style: headline5White)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              etfArr?.etfChange == null
                                  ? SizedBox()
                                  : Text(
                                      // "${etfArr.etfChange}",
                                      widget.chng,
                                      textAlign: TextAlign.center,
                                      style: highlightStyle.copyWith(
                                          color:
                                              // etfArr.etfChange.contains("-")
                                              widget.chng.contains("-")
                                                  ? red
                                                  : blue),
                                    ),
                              etfArr?.etfChangePer == null
                                  ? SizedBox()
                                  : Text(
                                      // "(${etfArr.etfChangePer})",
                                      widget.chngPercentage,
                                      textAlign: TextAlign.center,
                                      style: highlightStyle.copyWith(
                                          color:
                                              // etfArr.etfChangePer.contains("-")
                                              widget.chngPercentage
                                                      .contains("-")
                                                  ? red
                                                  : blue),
                                    ),
                            ])
                      ],
                      SizedBox(
                        height: 22,
                      ),
                      Expanded(
                        // height: 475,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _list.length,
                          itemBuilder: (c, i) => RowItem(_list[i] ?? "",
                              widget.isEtf == true ? etfValues[i] : values[i],
                              pad: 10),
                        ),
                      )
                    ],
                  ),
                ),
              );
  }
}

class OverviewPage2 extends StatefulWidget {
  final String query;
  OverviewPage2({
    Key key,
    this.query,
  }) : super(key: key);

  @override
  _OverviewPage2State createState() => _OverviewPage2State();
}

class _OverviewPage2State extends State<OverviewPage2> {
  CryptoModel2 crypto;
  bool loading = true;
  fetchApi() async {
    var c = await CryptoServices2.getCryptoDetails(widget.query);

    setState(() {
      crypto = c;
      print(crypto.marketCap);
      loading = false;
    });
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    // TODO: implement dispose

    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> _list = [
      "Previous Close",
      "Open",
      "Day's Range",
      "52 Week Range",
      "Start date",
      "Algorithm",
      "Market Cap (₹)",
      "Circulating Supply (₹)",
      "Max Supply (₹)",
      "Volume (₹)",
      "Volume (24 hrs) (₹)",
      "Volume (24 hrs) all currencies (₹)",
    ];
    List<String> values = 
    crypto != null
        ? [
            crypto.regularMarketPreviousClose == null
                ? "-"
                : crypto.regularMarketPreviousClose.fmt ?? "",
            crypto.regularMarketOpen.fmt ?? "",
            crypto.regularMarketDayRange.fmt ?? "",
            crypto.fiftyTwoWeekRange.fmt ?? "",
            crypto.startDate.fmt?.toString()?.substring(0, 10) ?? "",
            "-",
            crypto.marketCap.fmt ?? "",
            crypto.circulatingSupply.fmt ?? "",
            "-",
            crypto.regularMarketVolume.fmt ?? "",
            crypto.volume24Hr.fmt ?? "",
            crypto.volumeAllCurrencies.fmt ?? "",
          ]
        : 
        ['', '', '', '', '', '', '', '', '', '', '', ''];

    return loading
        ? LoadingPage()
        : crypto == null
            ? NoDataAvailablePage()
            : SmartRefresher(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: 32),
                      if (true) ...[
                        Center(
                            child: Text("₹ "+crypto.regularMarketPrice.fmt ?? "-",
                                style: headline5White)),
                        Center(
                          child: Text(
                            (crypto.regularMarketChange.fmt[0] != '-'
                                ? '+' + crypto.regularMarketChange.fmt
                                : crypto.regularMarketChange.fmt)+"("+ (crypto.regularMarketChangePercent.fmt[0] != '-'
                                ? '+' + crypto.regularMarketChangePercent.fmt
                                : crypto.regularMarketChangePercent.fmt)+")",
                            textAlign: TextAlign.end,
                            style: highlightStyle.copyWith(
                                color: crypto.regularMarketChange.fmt[0] != '-'
                                    ? blue
                                    : red),
                          ),
                        ),
                      ],
                      // if (widget.isEtf) ...[
                      //   Center(
                      //       child: Text(widget.price,
                      //           // etfArr?.price ?? "",
                      //           style: headline5White)),
                      //   Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         etfArr?.etfChange == null
                      //             ? SizedBox()
                      //             : Text(
                      //                 // "${etfArr.etfChange}",
                      //                 widget.chng,
                      //                 textAlign: TextAlign.center,
                      //                 style: highlightStyle.copyWith(
                      //                     color:
                      //                         // etfArr.etfChange.contains("-")
                      //                         widget.chng.contains("-")
                      //                             ? red
                      //                             : blue),
                      //               ),
                      //         etfArr?.etfChangePer == null
                      //             ? SizedBox()
                      //             : Text(
                      //                 // "(${etfArr.etfChangePer})",
                      //                 widget.chngPercentage,
                      //                 textAlign: TextAlign.center,
                      //                 style: highlightStyle.copyWith(
                      //                     color:
                      //                         // etfArr.etfChangePer.contains("-")
                      //                         widget.chngPercentage
                      //                                 .contains("-")
                      //                             ? red
                      //                             : blue),
                      //               ),
                      //       ])
                      // ],
                      SizedBox(
                        height: 22,
                      ),
                      Expanded(
                        // height: 475,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _list.length,
                          itemBuilder: (c, i) =>
                              RowItem(_list[i] ?? "", values[i], pad: 10),
                        ),
                      )
                    ],
                  ),
                ),
              );
  }
}
