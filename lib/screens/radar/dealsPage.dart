import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/codeSearch.dart';
import 'package:technical_ind/components/flatTile.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/components/utils.dart';
import 'package:technical_ind/screens/stocks/explore/home.dart';
import 'package:technical_ind/widgets/appbar_with_back_and_search.dart';
import 'business/deals/deals_model.dart';
import 'business/deals/deals_services.dart';
import '../../styles.dart';

class DealsPage extends StatefulWidget {
  @override
  _DealsPageState createState() => _DealsPageState();
}

class _DealsPageState extends State<DealsPage> {
  Dealsmodel nseresults;
  Dealsmodel bseresults;
  bool _loading = true;

  void getDealsResults() async {
    nseresults = await DealsServices.getSectorSenseList('nse');
    bseresults = await DealsServices.getSectorSenseList('bse');
    setState(() {
      _loading = false;
    });
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    getDealsResults();
  }

  List<bool> flag = [true, false];

  List<String> titleRow = ["Traded", "Closed", "Quantity"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(112),
            child: Column(
              children: [
                AppBarWithBack(
                  text: "Deals",
                ),
                TabBar(
                  labelStyle: buttonWhite,
                  unselectedLabelColor: Colors.white38,
                  indicator: MaterialIndicator(
                    horizontalPadding: 24,
                    bottomLeftRadius: 8,
                    bottomRightRadius: 8,
                    color: almostWhite,
                    paintingStyle: PaintingStyle.fill,
                  ),
                  tabs: [
                    Tab(text: "Bulk"),
                    Tab(text: "Block"),
                    Tab(text: "Large"),
                    Tab(text: 'Insider')
                  ],
                ),
              ],
            ),
          ),
          body: _loading
              ? LoadingPage()
              : TabBarView(
                  children: [
                    bulk(),
                    block(),
                    bseresults == null || bseresults.largedeals.length == 0
                        ? NoDataAvailablePage(
                            message:
                                "We are updating the data. Please come back after sometime.",
                          )
                        : SmartRefresher(
                            controller: _refreshController,
                            enablePullDown: true,
                            enablePullUp: false,
                            header: ClassicHeader(
                              completeIcon:
                                  Icon(Icons.done, color: Colors.white60),
                              refreshingIcon: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                            onRefresh: () => getDealsResults(),
                            child: ListView.builder(
                                itemBuilder: (c, i) => large(
                                      bseresults.largedeals[i]?.companyName ??
                                          "",
                                      bseresults.largedeals[i]?.sector ?? "",
                                      bseresults.largedeals[i]?.exchange ?? "",
                                      bseresults.largedeals[i]?.price ?? "",
                                      bseresults.largedeals[i]?.quantity ?? "",
                                      bseresults.largedeals[i]?.valueCr ?? "",
                                      bseresults.largedeals[i]?.stockCode ?? "",
                                    ),
                                itemCount: bseresults.largedeals.length),
                          ),
                    (nseresults == null ||
                                nseresults.insiderdeals.length == 0) &&
                            (bseresults == null ||
                                bseresults.insiderdeals.length == 0)
                        ? NoDataAvailablePage(
                            message:
                                "We are updating the data. Please come back after sometime.",
                          )
                        : (bseresults != null ||
                                bseresults.insiderdeals.length != 0)
                            ? SmartRefresher(
                                controller: _refreshController,
                                enablePullDown: true,
                                enablePullUp: false,
                                header: ClassicHeader(
                                  completeIcon:
                                      Icon(Icons.done, color: Colors.white60),
                                  refreshingIcon: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      color: Colors.white60,
                                    ),
                                  ),
                                ),
                                onRefresh: () => getDealsResults(),
                                child: ListView.builder(
                                    itemBuilder: (c, i) => insider(
                                          bseresults.insiderdeals[i]
                                                  ?.reportedToExchange ??
                                              "",
                                          bseresults.insiderdeals[i]?.action ??
                                              "",
                                          bseresults
                                                  .insiderdeals[i]?.stockName ??
                                              "",
                                          bseresults.insiderdeals[i]
                                                  ?.clientName ??
                                              "",
                                          bseresults.insiderdeals[i]
                                                  ?.clientCategory ??
                                              "",
                                          bseresults
                                                  .insiderdeals[i]?.quantity ??
                                              "",
                                          bseresults.insiderdeals[i]
                                                  ?.postTransactionHolding ??
                                              "",
                                          bseresults
                                                  .insiderdeals[i]?.avgPrice ??
                                              "",
                                          bseresults.insiderdeals[i]
                                                  ?.reportedToExchange ??
                                              "",
                                          bseresults.insiderdeals[i]?.trade ??
                                              "",
                                          bseresults
                                                  .insiderdeals[i]?.stockCode ??
                                              "",
                                        ),
                                    itemCount: bseresults.insiderdeals.length),
                              )
                            : (nseresults != null ||
                                    nseresults.insiderdeals.length != 0)
                                ? SmartRefresher(
                                    controller: _refreshController,
                                    enablePullDown: true,
                                    enablePullUp: false,
                                    header: ClassicHeader(
                                      completeIcon: Icon(Icons.done,
                                          color: Colors.white60),
                                      refreshingIcon: SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                          color: Colors.white60,
                                        ),
                                      ),
                                    ),
                                    onRefresh: () => getDealsResults(),
                                    child: ListView.builder(
                                        itemBuilder: (c, i) => insider(
                                              nseresults.insiderdeals[i]
                                                      ?.reportedToExchange ??
                                                  "",
                                              nseresults.insiderdeals[i]
                                                      ?.action ??
                                                  "",
                                              nseresults.insiderdeals[i]
                                                      ?.stockName ??
                                                  "",
                                              nseresults.insiderdeals[i]
                                                      ?.clientName ??
                                                  "",
                                              nseresults.insiderdeals[i]
                                                      ?.clientCategory ??
                                                  "",
                                              nseresults.insiderdeals[i]
                                                      ?.quantity ??
                                                  "",
                                              nseresults.insiderdeals[i]
                                                      ?.postTransactionHolding ??
                                                  "",
                                              nseresults.insiderdeals[i]
                                                      ?.avgPrice ??
                                                  "",
                                              nseresults.insiderdeals[i]
                                                      ?.reportedToExchange ??
                                                  "",
                                              nseresults
                                                      .insiderdeals[i]?.trade ??
                                                  "",
                                              nseresults.insiderdeals[i]
                                                      ?.stockCode ??
                                                  "",
                                            ),
                                        itemCount:
                                            nseresults.insiderdeals.length),
                                  )
                                : NoDataAvailablePage(
                                    message:
                                        "We are updating the data. Please come back after sometime.",
                                  ),
                  ],
                ),
        ));
  }

  Widget block() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_button('BSE', 0), _button('NSE', 1)],
            ),
          ),
        ),
        SizedBox(height: 24),
        flag[0]
            //for BSE
            ? bseresults == null || bseresults?.blockdeals?.length == 0
                ? Expanded(child: NoDataAvailablePage())
                : Expanded(
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
                      onRefresh: () => getDealsResults(),
                      child: ListView.builder(
                        itemBuilder: (context, i) {
                          return buildListView(
                            context,
                            bseresults.blockdeals[i]?.client ?? "",
                            bseresults.blockdeals[i]?.company ?? "",
                            bseresults.blockdeals[i]?.transaction ?? "",
                            bseresults.blockdeals[i]?.date ?? "",
                            bseresults.blockdeals[i]?.traded ?? "",
                            bseresults.blockdeals[i]?.closed ?? "",
                            bseresults.blockdeals[i]?.quantity ?? "",
                            bseresults.blockdeals[i]?.stockCode ?? "",
                          );
                        },
                        itemCount: bseresults.blockdeals.length,
                      ),
                    ),
                  )
            : nseresults == null || nseresults?.blockdeals?.length == 0
                ? Expanded(child: NoDataAvailablePage())
                : Expanded(
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
                      onRefresh: () => getDealsResults(),
                      child: ListView.builder(
                        itemBuilder: (context, i) {
                          return buildListView(
                            context,
                            nseresults.blockdeals[i]?.client ?? "",
                            nseresults.blockdeals[i]?.company ?? "",
                            nseresults.blockdeals[i]?.transaction ?? "",
                            nseresults.blockdeals[i]?.date ?? "",
                            nseresults.blockdeals[i]?.traded ?? "",
                            nseresults.blockdeals[i]?.closed ?? "",
                            nseresults.blockdeals[i]?.quantity ?? "",
                            nseresults.blockdeals[i]?.stockCode ?? "",
                          );
                        },
                        itemCount: nseresults.blockdeals.length,
                      ),
                    ),
                  ),
      ],
    );
  }

  buildListView(
      BuildContext context,
      String client,
      String company,
      String transaction,
      String date,
      String traded,
      String closed,
      String quantity,
      String stockCode,
      {bool redirect = true}) {
    return InkWell(
      onTap: () {
        if (redirect)
          pushNewScreen(
            context,
            withNavBar: false,
            screen: Homepage(
              name: company,
              // isin: codeSearch.isin,
              stockCode: stockCode,
            ),
          );
      },
      child: FlatTile(
        valueRow: [traded, closed, quantity],
        titleRow: titleRow,
        midWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              client,
              textAlign: TextAlign.center,
              style: captionWhite60,
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: transaction == 'Sell' ? red : blue,
                  borderRadius: BorderRadius.circular(4.00),
                ),
                child: Text(
                  transaction ?? "",
                  textAlign: TextAlign.center,
                  style: captionWhite,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(date ?? "", style: captionWhite60),
          ],
        ),
        title: company ?? "",
      ),
    );
  }

  Widget card(String client, String company, String transaction, String date,
      String traded, String closed, String quantity) {
    return Container(
      height: 215,
      width: 0.44 * MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: darkGrey,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            client ?? "",
            textAlign: TextAlign.center,
            style: subtitle1White,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
          Text(
            company ?? "",
            textAlign: TextAlign.center,
            style: captionWhite60,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
          SizedBox(height: 10),
          new Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: transaction == 'Sell' ? red : blue,
              borderRadius: BorderRadius.circular(4.00),
            ),
            child: Text(
              transaction ?? "",
              textAlign: TextAlign.center,
              style: captionWhite,
            ),
          ),
          SizedBox(height: 5),
          Text(date ?? "", style: captionWhite60),
          SizedBox(height: 13),
          row('Traded', traded ?? ""),
          row('Closed', closed ?? ""),
          row('Quantity', quantity ?? "")
        ],
      ),
    );
  }

  List<String> blues = ['Acquisition', 'Revoke'];
  List<String> reds = ['Pledge', 'Ivoke', 'Disposal', 'Pledged'];

  Widget insider(
      String reportexchange,
      String action,
      String stockname,
      String clientname,
      String clientcategory,
      String quantity,
      String postransaction,
      String avgprice,
      String reportedprice,
      String tradepercent,
      String stockCode) {
    return InkWell(
      onTap: () {
        pushNewScreen(
          context,
          withNavBar: false,
          screen: Homepage(
            name: stockname,
            stockCode: stockCode,
            isEvents: true,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: darkGrey,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(reportexchange ?? "",
                      //textAlign: TextAlign.center,
                      style: captionWhite60),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: reds.contains(action ?? "") ? red : blue,
                      borderRadius: BorderRadius.circular(4.00),
                    ),
                    child: Text(action ?? "",
                        textAlign: TextAlign.center, style: captionWhite),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(stockname ?? "",
                textAlign: TextAlign.center, style: subtitle1White),
            SizedBox(height: 10),
            Text(clientname.trim() ?? "",
                textAlign: TextAlign.center, style: bodyText2White),
            Text(clientcategory ?? "", style: captionWhite60),
            SizedBox(height: 14),
            row('Quantity', quantity ?? ""),
            row('Post Transaction holding', postransaction ?? ""),
            row('Average Price', avgprice ?? ""),
            row('Reported to Exchg', reportexchange ?? ""),
            row('Trade %', tradepercent ?? ""),
          ],
        ),
      ),
    );
  }

  Widget large(String name, String sector, String exchange, String price,
      String quantity, String value, String stockCode) {
    return name == null ||
            sector == null ||
            exchange == null ||
            price == null ||
            quantity == null ||
            value == null ||
            stockCode == null
        ? Expanded(child: NoDataAvailablePage())
        : InkWell(
            onTap: () {
              pushNewScreen(
                context,
                withNavBar: false,
                screen: Homepage(
                  name: name,
                  // isin: codeSearch.isin,
                  stockCode: stockCode,
                ),
              );
            },
            child: Container(
              height: 230,
              margin: EdgeInsets.symmetric(vertical: 4),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: darkGrey,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 5),
                      Text(name ?? "", style: subtitle1White),
                      Text(sector ?? "", style: bodyText2White),
                      SizedBox(height: 8),
                      SizedBox(height: 26),
                      row('Exchange', exchange ?? ""),
                      row('Price', price ?? ""),
                      row('Quantity', quantity ?? ""),
                      row('Value (Cr)', value ?? ""),
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  Widget row(String a, String b) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(a, style: bodyText2White60),
          Text(b, style: bodyText2White)
        ],
      ),
    );
  }

  Widget _button(String txt, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            for (int i = 0; i < 2; i++) flag[i] = false;
            flag[index] = true;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: flag[index] ? almostWhite : Colors.black,
          ),
          child: Center(
            child: Text(
              txt,
              textAlign: TextAlign.center,
              style: button.copyWith(color: flag[index] ? darkGrey : white38),
            ),
          ),
        ),
      ),
    );
  }

  Widget bulk() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_button('BSE', 0), _button('NSE', 1)],
            ),
          ),
        ),
        SizedBox(height: 24),
        flag[0]
            ?
            //for BSE
            bseresults == null || bseresults.bulkdeals.length == 0
                ? Expanded(child: NoDataAvailablePage())
                : Expanded(
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
                      onRefresh: () => getDealsResults(),
                      child: ListView.builder(
                        itemBuilder: (context, i) {
                          return buildListView(
                              context,
                              bseresults.bulkdeals[i]?.client ?? "",
                              bseresults.bulkdeals[i]?.company ?? "",
                              bseresults.bulkdeals[i]?.transaction ?? "",
                              bseresults.bulkdeals[i]?.date ?? "",
                              bseresults.bulkdeals[i]?.traded ?? "",
                              bseresults.bulkdeals[i]?.closed ?? "",
                              bseresults.bulkdeals[i]?.quantity ?? "",
                              bseresults.bulkdeals[i]?.stockCode ?? "",
                              redirect: false);
                        },
                        itemCount: bseresults.bulkdeals.length,
                      ),
                    ),
                  )
            : nseresults == null || nseresults.bulkdeals.length == 0
                ? Expanded(child: NoDataAvailablePage())
                : Expanded(
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
                      onRefresh: () => getDealsResults(),
                      child: ListView.builder(
                        itemBuilder: (context, i) {
                          return buildListView(
                              context,
                              nseresults.bulkdeals[i]?.client ?? "",
                              nseresults.bulkdeals[i]?.company ?? "",
                              nseresults.bulkdeals[i]?.transaction ?? "",
                              nseresults.bulkdeals[i]?.date ?? "",
                              nseresults.bulkdeals[i]?.traded ?? "",
                              nseresults.bulkdeals[i]?.closed ?? "",
                              nseresults.bulkdeals[i]?.quantity ?? "",
                              nseresults.bulkdeals[i]?.stockCode ?? "",
                              redirect: false);
                        },
                        itemCount: nseresults.bulkdeals.length,
                      ),
                    ),
                  )
      ],
    );
  }

  Widget card2() {
    return Container(
      height: 215,
      width: 0.44 * MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: darkGrey,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('A & M Febcom',
              textAlign: TextAlign.center, style: subtitle1White),
          Text('Zalak Purvesh Parikh',
              textAlign: TextAlign.center, style: captionWhite60),
          SizedBox(height: 10),
          new Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: blue,
              borderRadius: BorderRadius.circular(4.00),
            ),
            child:
                Text('Buy', textAlign: TextAlign.center, style: captionWhite),
          ),
          SizedBox(height: 5),
          Text('02 Oct 2020', style: captionWhite60),
          SizedBox(height: 13),
          row('Traded', '2.60'),
          row('Closed', '2.59'),
          row('Quantity', '70,741')
        ],
      ),
    );
  }
}
