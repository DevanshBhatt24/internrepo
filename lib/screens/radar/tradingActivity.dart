import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
// import 'package:flutter_screenutil/size_extension.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/radar/business/radarServices.dart';
import 'package:technical_ind/screens/radar/business/tradingActivity.dart';

import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';

class IndividualScreen extends StatefulWidget {
  final String s;
  final String title;
  final String net;
  final String gp;
  final String gs;
  final String monthyear;
  final bool isCurrent;
  final bool cash_Fii;
  final bool cash_Dii;
  final bool Derivative_IndFut;
  final bool Derivative_IndOpt;
  final bool Derivative_stockFut;
  final bool Derivative_stockOpt;
  final bool SebiMfDebt;
  final bool SebiMfEquity;
  final bool SebiFiiDebt;
  final bool SebiMfFiiEquity;

  const IndividualScreen(
      {Key key,
      this.s,
      this.title,
      this.net,
      this.gp,
      this.gs,
      this.monthyear,
      this.isCurrent = false,
      this.cash_Fii = false,
      this.cash_Dii = false,
      this.Derivative_IndFut = false,
      this.Derivative_IndOpt = false,
      this.Derivative_stockFut = false,
      this.Derivative_stockOpt = false,
      this.SebiMfDebt = false,
      this.SebiMfEquity = false,
      this.SebiFiiDebt = false,
      this.SebiMfFiiEquity = false})
      : super(key: key);

  @override
  _IndividualScreenState createState() => _IndividualScreenState();
}

class _IndividualScreenState extends State<IndividualScreen> {
  List<FilteredDii> filteredTradingActivityModel;
  List<Dii> dii;
  Map<String, dynamic> total = {};
  bool loading = true;
  double grossPurchase = 0.0;
  double grossSales = 0.0;
  double netPurchaseSales = 0.0;

  _fetchApi() async {
    // print(widget.s);
    if (widget.isCurrent) {
      final data = await RadarServices.currentTradingActivity();
      if (data != null) {
        if (widget.cash_Fii) {
          dii = data.data.cash.fii;
        } else if (widget.cash_Dii) {
          dii = data.data.cash.dii;
        } else if (widget.Derivative_IndFut) {
          dii = data.data.derivative.indexFut;
        } else if (widget.Derivative_IndOpt) {
          dii = data.data.derivative.indexOpt;
        } else if (widget.Derivative_stockFut) {
          dii = data.data.derivative.stockFut;
        } else if (widget.Derivative_stockOpt) {
          dii = data.data.derivative.stockOpt;
        } else if (widget.SebiFiiDebt) {
          dii = data.data.sebi.fiiDebt;
        } else if (widget.SebiMfDebt) {
          dii = data.data.sebi.mfDebt;
        } else if (widget.SebiMfEquity) {
          dii = data.data.sebi.mfEquity;
        } else if (widget.SebiMfFiiEquity) {
          dii = data.data.sebi.fiiEquity;
        }
        for (int i = 0; i < dii.length; i++) {
          grossPurchase += double.parse(dii[i]
              .grossPurchase
              .replaceAll(",", "")
              .replaceAll("(", "")
              .replaceAll(")", ""));
          grossSales += double.parse(dii[i]
              .grossSales
              .replaceAll(",", "")
              .replaceAll("(", "")
              .replaceAll(")", ""));
        }
        netPurchaseSales = grossPurchase - grossSales;
      }
    } else {
      final data = await RadarServices.filteredTradingActivity(widget.s);
      filteredTradingActivityModel = data["data"];
      total = data["total"];
    }
    setState(() {
      loading = false;
    });
    _refreshController.refreshCompleted();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _fetchApi();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(text: widget.title),
      body: SmartRefresher(
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: loading
              ? LoadingPage()
              : widget.isCurrent
                  ? dii != null || dii.length == 0
                      ? Column(
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(height: 24),
                            Text(widget.monthyear,
                                textAlign: TextAlign.center,
                                style: subtitle1White),
                            SizedBox(height: 26),
                            Center(
                              child: Text(
                                  netPurchaseSales.toStringAsFixed(2) ?? "",
                                  style: bodyText2.copyWith(
                                      color: double.parse(widget.net
                                                  .replaceAll(",", "")) <
                                              0
                                          ? red
                                          : blue)),
                            ),
                            SizedBox(height: 2),
                            Center(
                              child: Text('Net Purchase/Sales',
                                  style: captionWhite60),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: <Widget>[
                                    Text(grossPurchase.toStringAsFixed(2) ?? "",
                                        textAlign: TextAlign.center,
                                        style: subtitle18),
                                    Text('Gross Purchase',
                                        style: captionWhite60)
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(grossSales.toStringAsFixed(2) ?? "",
                                        textAlign: TextAlign.end,
                                        style: subtitle18),
                                    Text('Gross Sales', style: captionWhite60)
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 32),
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (c, i) => customTileDetail(
                                      date: dii[i].month ?? "",
                                      gp: dii[i].grossPurchase ?? "",
                                      gs: dii[i].grossSales ?? "",
                                      net: dii[i].netPurchasePerSales ?? ""),
                                  itemCount: dii.length),
                            )
                          ],
                        )
                      : Expanded(child: NoDataAvailablePage())
                  : filteredTradingActivityModel != null ||
                          filteredTradingActivityModel.length == 0
                      ? Column(
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(height: 24),
                            Text(widget.monthyear,
                                textAlign: TextAlign.center,
                                style: subtitle1White),
                            SizedBox(height: 26),
                            if (total.length != 0)
                              Center(
                                child: Text(
                                    total["net_purchase_per_sales"] ?? "",
                                    style: bodyText2.copyWith(
                                        color: double.parse(widget.net
                                                    .replaceAll(",", "")) <
                                                0
                                            ? red
                                            : blue)),
                              ),
                            SizedBox(height: 2),
                            if (total.length != 0)
                              Center(
                                child: Text('Net Purchase/Sales',
                                    style: captionWhite60),
                              ),
                            SizedBox(height: 16),
                            if (total.length != 0)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: <Widget>[
                                      Text(total["gross_purchase"] ?? "",
                                          textAlign: TextAlign.center,
                                          style: subtitle18),
                                      Text('Gross Purchase',
                                          style: captionWhite60)
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(total["gross_sales"] ?? "",
                                          textAlign: TextAlign.end,
                                          style: subtitle18),
                                      Text('Gross Sales', style: captionWhite60)
                                    ],
                                  ),
                                ],
                              ),
                            SizedBox(height: 32),
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (c, i) => customTileDetail(
                                      date: filteredTradingActivityModel[i]
                                              ?.date ??
                                          "",
                                      gp: filteredTradingActivityModel[i]
                                              ?.grossPurchase ??
                                          "",
                                      gs: filteredTradingActivityModel[i]
                                              ?.grossSales ??
                                          "",
                                      net: filteredTradingActivityModel[i]
                                              ?.netPurchasePerSales ??
                                          ""),
                                  itemCount:
                                      filteredTradingActivityModel?.length ??
                                          0),
                            )
                          ],
                        )
                      : Expanded(child: NoDataAvailablePage()),
        ),
      ),
    );
  }

  Widget customTileDetail(
      {String s = "", String date, String net, String gp, String gs}) {
    final _date = date.split('-');
    return Container(
      height: 130,
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56,
            child: Text(
              "${_date[0]}\n${_date[1].substring(0, 3)}" ?? "",
              textAlign: TextAlign.center,
              style: subtitle2White,
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: darkGrey,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("₹ " + net,
                            style: bodyText2.copyWith(
                                color: double.parse(net.replaceAll(",", "")) < 0
                                    ? red
                                    : blue)),
                        Text('Net Purchase/Sales',
                            textAlign: TextAlign.center, style: captionWhite60),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Gross Purchase', style: captionWhite60),
                            Text(gp,
                                textAlign: TextAlign.end, style: captionWhite)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Gross Sales', style: captionWhite60),
                        Text(gs, textAlign: TextAlign.end, style: captionWhite)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TradingActivity extends StatefulWidget {
  @override
  _TradingActivityState createState() => _TradingActivityState();
}

class _TradingActivityState extends State<TradingActivity> {
  int selectedIndex2 = 0;
  int selectedIndex4 = 0;
  List<TradingActivityModel> tradingActivityModel;
  bool loading = true;

  _fetchApi() async {
    tradingActivityModel = await RadarServices.tradingActivity();
    setState(() {
      loading = false;
    });
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    _fetchApi();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(106),
          child: Column(
            children: [
              AppBarWithBack(
                text: "Trading Activity",
              ),
              TabBar(
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
                    text: "CASH",
                  ),
                  Tab(
                    text: "DERIVATIVE",
                  ),
                  Tab(
                    text: "SEBI",
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: loading
              ? LoadingPage()
              : tradingActivityModel != null
                  ? TabBarView(
                      children: [
                        Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _button2('FII', 0),
                                  _button2('DII', 1)
                                ],
                              ),
                            ),
                            selectedIndex2 == 0
                                ? (tradingActivityModel[1].data.cash.fii == null &&
                                            tradingActivityModel[0].data.cash.fii ==
                                                null) ||
                                        (tradingActivityModel[1].data.cash.fii.length == 0 &&
                                            tradingActivityModel[0]
                                                    .data
                                                    .cash
                                                    .fii
                                                    .length ==
                                                0)
                                    ? Expanded(child: NoDataAvailablePage())
                                    : section(
                                        cash_Fii: true,
                                        d: tradingActivityModel[1].data.cash.fii +
                                            tradingActivityModel[0]
                                                .data
                                                .cash
                                                .fii,
                                        title: 'FII',
                                        section: 'cash',
                                        subsection: 'fii')
                                : (tradingActivityModel[1].data.cash.dii == null &&
                                            tradingActivityModel[0].data.cash.dii ==
                                                null) ||
                                        (tradingActivityModel[1].data.cash.dii.length == 0 &&
                                            tradingActivityModel[0]
                                                    .data
                                                    .cash
                                                    .dii
                                                    .length ==
                                                0)
                                    ? Expanded(child: NoDataAvailablePage())
                                    : section(
                                        cash_Dii: true,
                                        d: tradingActivityModel[1].data.cash.dii +
                                            tradingActivityModel[0].data.cash.dii,
                                        title: 'DII',
                                        section: 'cash',
                                        subsection: 'dii')
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _button4('Index Fut', 0),
                                  _button4('Index Opt', 1),
                                  _button4('Stock Fut', 2),
                                  _button4('Stock Opt', 3),
                                ],
                              ),
                            ),
                            selectedIndex4 == 0
                                ? (tradingActivityModel[1].data.derivative.indexFut == null &&
                                            tradingActivityModel[1].data.derivative.indexFut +
                                                    tradingActivityModel[0]
                                                        .data
                                                        .derivative
                                                        .indexFut ==
                                                null) ||
                                        tradingActivityModel[1].data.derivative.indexFut.length +
                                                tradingActivityModel[0]
                                                    .data
                                                    .derivative
                                                    .indexFut
                                                    .length ==
                                            0
                                    ? Expanded(child: NoDataAvailablePage())
                                    : section(
                                        Derivative_IndFut: true,
                                        d: tradingActivityModel[1].data.derivative.indexFut +
                                            tradingActivityModel[0]
                                                .data
                                                .derivative
                                                .indexFut,
                                        title: 'Index Future',
                                        section: "derivative",
                                        subsection: "index_fut")
                                : selectedIndex4 == 1
                                    ? (tradingActivityModel[1].data.derivative.indexOpt == null && tradingActivityModel[1].data.derivative.indexOpt + tradingActivityModel[0].data.derivative.indexFut == null) ||
                                            (tradingActivityModel[1].data.derivative.indexOpt.length +
                                                    tradingActivityModel[0]
                                                        .data
                                                        .derivative
                                                        .indexFut
                                                        .length ==
                                                0)
                                        ? Expanded(child: NoDataAvailablePage())
                                        : section(
                                            Derivative_IndOpt: true,
                                            d: tradingActivityModel[1].data.derivative.indexOpt + tradingActivityModel[0].data.derivative.indexOpt,
                                            title: 'Index Option',
                                            section: "derivative",
                                            subsection: "index_opt")
                                    : selectedIndex4 == 2
                                        ? (tradingActivityModel[1].data.derivative.stockFut + tradingActivityModel[0].data.derivative.stockFut == null) || (tradingActivityModel[1].data.derivative.stockFut.length + tradingActivityModel[0].data.derivative.stockFut.length == 0)
                                            ? Expanded(child: NoDataAvailablePage())
                                            : section(Derivative_stockFut: true, d: tradingActivityModel[1].data.derivative.stockFut + tradingActivityModel[0].data.derivative.stockFut, title: 'Stock Future', section: "derivative", subsection: "stock_fut")
                                        : (tradingActivityModel[1].data.derivative.stockOpt + tradingActivityModel[0].data.derivative.stockOpt == null) || (tradingActivityModel[1].data.derivative.stockOpt.length + tradingActivityModel[0].data.derivative.stockOpt.length == 0)
                                            ? Expanded(child: NoDataAvailablePage())
                                            : section(Derivative_stockOpt: true, d: tradingActivityModel[1].data.derivative.stockOpt + tradingActivityModel[0].data.derivative.stockOpt, title: 'Stock Option', section: "derivative", subsection: "stock_opt")
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _button4('MF Debt', 0),
                                  _button4('MF Equity', 1),
                                  _button4('FII Debt', 2),
                                  _button4('FII Equity', 3),
                                ],
                              ),
                            ),
                            selectedIndex4 == 0
                                ? (tradingActivityModel[1].data.sebi.mfDebt + tradingActivityModel[0].data.sebi.mfDebt == null) ||
                                        (tradingActivityModel[1].data.sebi.mfDebt.length +
                                                tradingActivityModel[0]
                                                    .data
                                                    .sebi
                                                    .mfDebt
                                                    .length ==
                                            0)
                                    ? Expanded(child: NoDataAvailablePage())
                                    : section(
                                        SebiMfDebt: true,
                                        d: tradingActivityModel[1].data.sebi.mfDebt +
                                            tradingActivityModel[0]
                                                .data
                                                .sebi
                                                .mfDebt,
                                        title: 'MF Debt',
                                        section: 'sebi',
                                        subsection: 'mf_debt')
                                : selectedIndex4 == 1
                                    ? (tradingActivityModel[1].data.sebi.mfEquity + tradingActivityModel[0].data.sebi.mfEquity == null) ||
                                            (tradingActivityModel[1].data.sebi.mfEquity.length +
                                                    tradingActivityModel[0]
                                                        .data
                                                        .sebi
                                                        .mfEquity
                                                        .length ==
                                                0)
                                        ? Expanded(child: NoDataAvailablePage())
                                        : section(
                                            SebiMfEquity: true,
                                            d: tradingActivityModel[1].data.sebi.mfEquity +
                                                tradingActivityModel[0]
                                                    .data
                                                    .sebi
                                                    .mfEquity,
                                            title: 'MF Equity',
                                            section: 'sebi',
                                            subsection: 'mf_debt')
                                    : selectedIndex4 == 2
                                        ? (tradingActivityModel[1].data.sebi.fiiDebt +
                                                        tradingActivityModel[0].data.sebi.fiiDebt ==
                                                    null) ||
                                                (tradingActivityModel[1].data.sebi.fiiDebt.length + tradingActivityModel[0].data.sebi.fiiDebt.length == 0)
                                            ? Expanded(child: NoDataAvailablePage())
                                            : section(SebiFiiDebt: true, d: tradingActivityModel[1].data.sebi.fiiDebt + tradingActivityModel[0].data.sebi.fiiDebt, title: 'FII Debt', section: 'sebi', subsection: 'fii_debt')
                                        : (tradingActivityModel[1].data.sebi.fiiEquity + tradingActivityModel[0].data.sebi.fiiEquity == null) || (tradingActivityModel[1].data.sebi.fiiEquity.length + tradingActivityModel[0].data.sebi.fiiEquity.length == 0)
                                            ? Expanded(child: NoDataAvailablePage())
                                            : section(SebiMfFiiEquity: true, d: tradingActivityModel[1].data.sebi.fiiEquity + tradingActivityModel[0].data.sebi.fiiEquity, title: 'FII Equity', section: 'sebi', subsection: 'fii_equity')
                          ],
                        ),
                      ],
                    )
                  : NoDataAvailablePage(),
        ),
      ),
    );
  }

  Widget section(
      {List<Dii> d,
      String title,
      String section = "",
      String subsection = "",
      bool isCurrent = false,
      bool cash_Fii = false,
      bool cash_Dii = false,
      bool Derivative_IndFut = false,
      bool Derivative_IndOpt = false,
      bool Derivative_stockFut = false,
      bool Derivative_stockOpt = false,
      bool SebiMfDebt = false,
      bool SebiMfEquity = false,
      bool SebiFiiDebt = false,
      bool SebiMfFiiEquity = false}) {
    return Expanded(
      child: SmartRefresher(
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
          child: ListView.builder(
            itemCount: d.length,
            itemBuilder: (c, i) => customTile(
              Derivative_IndFut: Derivative_IndFut,
              Derivative_IndOpt: Derivative_IndOpt,
              Derivative_stockFut: Derivative_stockFut,
              Derivative_stockOpt: Derivative_stockOpt,
              SebiFiiDebt: SebiFiiDebt,
              SebiMfDebt: SebiMfDebt,
              SebiMfEquity: SebiMfEquity,
              SebiMfFiiEquity: SebiMfFiiEquity,
              cash_Dii: cash_Dii,
              cash_Fii: cash_Fii,
              isCurrent: i == 0 ? true : false,
              section: section,
              subsection: subsection,
              s: title,
              monthtemp: d[i].month.split(' ')[0],
              yeartemp: d[i].month.split(' ')[1],
              month: d[i].month.split(' ')[0].substring(0, 3) +
                  ' ' +
                  d[i].month.split(' ')[1],
              net: d[i].netPurchasePerSales,
              gp: d[i].grossPurchase,
              gs: d[i].grossSales,
            ),
          )),
    );
  }

  String convertTonum(String monthtemp) {
    if (monthtemp == "January") {
      return "01";
    } else if (monthtemp == "February") {
      return "02";
    } else if (monthtemp == "March") {
      return "03";
    } else if (monthtemp == "April") {
      return "04";
    } else if (monthtemp == "May") {
      return "05";
    } else if (monthtemp == "June") {
      return "06";
    } else if (monthtemp == "July") {
      return "07";
    } else if (monthtemp == "August") {
      return "08";
    } else if (monthtemp == "September") {
      return "09";
    } else if (monthtemp == "October") {
      return "10";
    } else if (monthtemp == "November") {
      return "11";
    } else if (monthtemp == "December") {
      return "12";
    } else
      return "";
  }

  Widget customTile(
      {String section,
      String subsection,
      String s,
      String monthtemp,
      String yeartemp,
      String month,
      String net,
      String gp,
      String gs,
      bool isCurrent,
      bool cash_Fii = false,
      bool cash_Dii = false,
      bool Derivative_IndFut = false,
      bool Derivative_IndOpt = false,
      bool Derivative_stockFut = false,
      bool Derivative_stockOpt = false,
      bool SebiMfDebt = false,
      bool SebiMfEquity = false,
      bool SebiFiiDebt = false,
      bool SebiMfFiiEquity = false}) {
    String monthInt;

    monthInt = convertTonum(monthtemp);

    return Container(
      height: 130,
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56,
            child: Text(
              month ?? "",
              textAlign: TextAlign.center,
              style: subtitle2White,
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () async {
                print(monthInt);
                print(section);
                print(subsection);
                print("${monthInt}_$yeartemp");
                String url = isCurrent
                    ? 'https://api.bottomstreet.com/api/data?page=trading_activity_current_month'
                    : section != "cash"
                        ? 'https://api.bottomstreet.com/api/data/filters?page=trading_activity_$subsection&filter_names=["section","subsection","identifier"]&filter_values=["$section","$subsection","${monthInt}_$yeartemp"]'
                        : 'https://api.bottomstreet.com/api/data/filters?page=trading_activity_${section}_$subsection&filter_names=["section","subsection","identifier"]&filter_values=["$section","$subsection","${monthInt}_$yeartemp"]';
                // print(url);
                // var response = await http.get(Uri.parse(url));
                // print("hello");
                // print(json.decode(response.body));
                print(url);
                pushNewScreen(
                  context,
                  withNavBar: false,
                  screen: IndividualScreen(
                    Derivative_IndFut: Derivative_IndFut,
                    Derivative_IndOpt: Derivative_IndOpt,
                    Derivative_stockFut: Derivative_stockFut,
                    Derivative_stockOpt: Derivative_stockOpt,
                    SebiFiiDebt: SebiFiiDebt,
                    SebiMfDebt: SebiMfDebt,
                    SebiMfEquity: SebiMfEquity,
                    SebiMfFiiEquity: SebiMfFiiEquity,
                    cash_Dii: cash_Dii,
                    cash_Fii: cash_Fii,
                    isCurrent: isCurrent,
                    title: s,
                    s: url,
                    net: net,
                    gp: gp,
                    gs: gs,
                    monthyear: monthtemp + " " + yeartemp,
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: darkGrey,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("₹ " + net,
                            style: bodyText2.copyWith(
                                color: double.parse(net.replaceAll(",", "")) < 0
                                    ? red
                                    : blue)),
                        Text('Net Purchase/Sales',
                            textAlign: TextAlign.center, style: captionWhite60),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Gross Purchase', style: captionWhite60),
                            Text(gp,
                                textAlign: TextAlign.end, style: captionWhite)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Gross Sales', style: captionWhite60),
                        Text(gs, textAlign: TextAlign.end, style: captionWhite)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _button2(String txt, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex2 = index;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: selectedIndex2 == index ? almostWhite : Colors.black,
          ),
          child: Center(
            child: Text(
              txt,
              textAlign: TextAlign.center,
              style: button.copyWith(
                  color: selectedIndex2 == index ? darkGrey : white38),
            ),
          ),
        ),
      ),
    );
  }

  Widget _button4(String txt, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex4 = index;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: selectedIndex4 == index ? almostWhite : Colors.black,
          ),
          child: Center(
            child: Text(
              txt,
              textAlign: TextAlign.center,
              style: button.copyWith(
                  color: selectedIndex4 == index ? darkGrey : white38),
            ),
          ),
        ),
      ),
    );
  }
}
