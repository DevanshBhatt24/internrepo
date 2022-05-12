import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';

import '../../../styles.dart';

class DealsPage extends StatefulWidget {
  final String isin;
  DealsPage({this.isin});
  @override
  _DealsPageState createState() => _DealsPageState();
}

class _DealsPageState extends State<DealsPage> {
  Deals deals;
  bool loading = true;
  fetchApi() async {
    deals = await StockServices.stockDealstDetails(widget.isin);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : deals == null
            ? NoDataAvailablePage()
            : DefaultTabController(
                length: 4,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(55),
                    child: Column(
                      children: [
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
                            Tab(text: "Bulk"),
                            Tab(text: "Block"),
                            Tab(text: "Insider"),
                            Tab(text: 'SAST')
                          ],
                        ),
                      ],
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TabBarView(
                      children: [
                        Container(
                          child: ListView.builder(
                            itemBuilder: (c, i) => _bulk(
                              deals.bulkDeals[i].date ?? "",
                              deals.bulkDeals[i].dealType ?? "",
                              deals.bulkDeals[i].name ?? "",
                              deals.bulkDeals[i].price ?? "",
                              deals.bulkDeals[i].quantity ?? "",
                              deals.bulkDeals[i].traded ?? "",
                            ),
                            itemCount: deals.bulkDeals.length ?? 0,
                          ),
                        ),
                        Container(
                          child: ListView.builder(
                            itemBuilder: (c, i) => _bulk(
                              deals.blockDeals[i].date ?? "",
                              deals.blockDeals[i].dealType ?? "",
                              deals.blockDeals[i].name ?? "",
                              deals.blockDeals[i].price ?? "",
                              deals.blockDeals[i].quantity ?? "",
                              deals.blockDeals[i].traded ?? "",
                            ),
                            itemCount: deals.blockDeals.length ?? "",
                          ),
                        ),
                        Container(
                          child: ListView.builder(
                            itemBuilder: (c, i) => _insider(
                              date: deals.insiderDeals[i].date ?? "",
                              dealType: deals.insiderDeals[i].dealType ?? "",
                              group: deals.insiderDeals[i].group ?? "",
                              name: deals.insiderDeals[i].name ?? "",
                              postTxnHold:
                                  deals.insiderDeals[i].postTxnHold ?? "",
                              price: deals.insiderDeals[i].price ?? "",
                              quantity: deals.insiderDeals[i].quantity ?? "",
                              traded: deals.insiderDeals[i].traded ?? "",
                            ),
                            itemCount: deals.insiderDeals.length ?? 0,
                          ),
                        ),
                        Container(
                          child: ListView.builder(
                            itemBuilder: (c, i) => _insider(
                              date: deals.sastDeals[i].date ?? "",
                              dealType: deals.sastDeals[i].dealType ?? "",
                              group: deals.sastDeals[i].group ?? "",
                              name: deals.sastDeals[i].name ?? "",
                              postTxnHold: deals.sastDeals[i].postTxnHold ?? "",
                              price: deals.sastDeals[i].price ?? "",
                              quantity: deals.sastDeals[i].quantity ?? "",
                              traded: deals.sastDeals[i].traded ?? "",
                            ),
                            itemCount: deals.sastDeals.length ?? 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
  }

  Widget _bulk(
    String date,
    String dealtype,
    String name,
    String price,
    String quantity,
    String traded,
  ) {
    return Container(
      height: 136,
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 135,
                    child: MarqueeText(
                      text: TextSpan(text: name),
                      style: bodyText2White,
                      speed: 10,
                      // overflow: TextOverflow.fade,
                      // softWrap: false,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(date, style: captionWhite60)
                ]),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  decoration: BoxDecoration(
                    color: dealtype == 'Purchase' ? blue : red,
                    borderRadius: BorderRadius.circular(4.00),
                  ),
                  child: Text(dealtype,
                      textAlign: TextAlign.center, style: captionWhite),
                ),
              ]),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Quantity', style: bodyText2White60),
                      Text(quantity,
                          textAlign: TextAlign.start, style: bodyText2White)
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Price', style: bodyText2White60),
                      Text(price,
                          textAlign: TextAlign.center, style: bodyText2White)
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('% Traded', style: bodyText2White60),
                      Text(traded + ' %',
                          textAlign: TextAlign.end, style: bodyText2White)
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _insider(
      {String date,
      String dealType,
      String group,
      String name,
      String postTxnHold,
      String price,
      String quantity,
      String traded}) {
    return Container(
      // height: 173,
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Flexible(child: Text(date, style: captionWhite60)),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                    decoration: BoxDecoration(
                      color: red,
                      borderRadius: BorderRadius.circular(4.00),
                    ),
                    child: Text(dealType,
                        textAlign: TextAlign.center, style: captionWhite),
                  ),
                ),
              ]),
              SizedBox(height: 14),
              Text(name, style: bodyText2White),
              SizedBox(height: 2),
              Text(
                group,
                style: captionWhite60,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Quantity',
                          style: bodyText2White60, textAlign: TextAlign.center),
                      Text(quantity,
                          textAlign: TextAlign.center, style: bodyText2White)
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Post Txn Hold', style: bodyText2White60),
                      Text(postTxnHold,
                          textAlign: TextAlign.center, style: bodyText2White)
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Price', style: bodyText2White60),
                      Text(price, style: bodyText2White)
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('Trade %', style: bodyText2White60),
                      Text('$traded %',
                          textAlign: TextAlign.end, style: bodyText2White)
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
