import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/News/business/newsServices.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';
import 'package:technical_ind/styles.dart';
import 'package:technical_ind/widgets/miss.dart';
import 'package:technical_ind/widgets/tableItem.dart';
import 'business/model.dart';
import 'package:technical_ind/widgets/griditemnews.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';

class BroadcastPage extends StatefulWidget {
  final String isin;
  final List<Article> articles;
  BroadcastPage({Key key, this.isin, this.articles}) : super(key: key);

  @override
  _BroadcastPageState createState() => _BroadcastPageState();
}

class NewsArticle extends StatelessWidget {
  final String title, subtitle, date;

  const NewsArticle({Key key, this.title, this.subtitle, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: subtitle1White),
          SizedBox(
            height: 4,
          ),
          Text(date, style: captionWhite),
          SizedBox(
            height: 16,
          ),
          Text(subtitle, style: bodyText2White60),
        ],
      ),
    );
  }
}

class NewsWidget extends StatefulWidget {
  final bool isheadAvailable,
      isEtf,
      isIndice,
      isGlobal,
      isCrypto,
      isForex,
      isStock;
  final String title;
  final Future Function() refresh;
  final List<Article> articles;

  NewsWidget(
      {Key key,
      this.isIndice = false,
      this.isStock = false,
      this.isForex = false,
      this.isGlobal = false,
      this.isCrypto = false,
      this.title,
      this.isheadAvailable = false,
      this.isEtf = false,
      this.articles,
      this.refresh})
      : super(key: key);

  @override
  _NewsWidgetState createState() => _NewsWidgetState();
}

class _BroadcastPageState extends State<BroadcastPage> {
  Broadcast broadcast;
  bool loading = true;
  fetchApi() async {
    broadcast = await StockServices.stockBroadcastDetails(widget.isin);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : broadcast == null
            ? NoDataAvailablePage()
            : DefaultTabController(
                length: 2,
                child: Scaffold(
                  // appBar: TabBar(
                  //   // isScrollable: true,
                  //   labelStyle: bodyText2White,
                  //   unselectedLabelColor: Colors.white38,
                  //   //indicatorSize: TabBarIndicatorSize.label,
                  //   indicator: MaterialIndicator(
                  //     horizontalPadding: 6,
                  //     bottomLeftRadius: 8,
                  //     bottomRightRadius: 8,
                  //     color: almostWhite,
                  //     paintingStyle: PaintingStyle.fill,
                  //   ),
                  // tabs: [
                  //   // Tab(
                  //   //   text: "News",
                  //   // ),
                  //   Tab(
                  //     text: "Actions",
                  //   ),
                  //   Tab(
                  //     text: "Announcements",
                  //   ),
                  // ],
                  // ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child:
                        // TabBarView(
                        //   children: [
                        // NewsWidget(
                        //   articles: widget.articles,
                        // ),
                        SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text('Board Meetings', style: subtitle1White),
                            SizedBox(height: 26),
                            TableBar(
                              title1: "Date",
                              title2: "Agenda",
                            ),
                            SizedBox(height: 12),
                            ...List.generate(
                              broadcast.corporateAction.boardMeetings.length ??
                                  0,
                              (i) => TableItem(
                                title: broadcast.corporateAction
                                        .boardMeetings[i].date ??
                                    "",
                                value: broadcast.corporateAction
                                        .boardMeetings[i].agenda ??
                                    "",
                              ),
                            ),
                            // TableItem(
                            //   title: "21 Oct 2020",
                            //   value: "Quarterly Results",
                            // ),
                            // TableItem(
                            //   title: "21 Oct 2020",
                            //   value: "Quarterly Results",
                            // ),
                            // TableItem(
                            //   title: "21 Oct 2020",
                            //   value: "Quarterly Results",
                            // ),
                            // TableItem(
                            //   title: "21 Oct 2020",
                            //   value: "Quarterly Results",
                            // ),
                            // TableItem(
                            //   title: "21 Oct 2020",
                            //   value: "Quarterly Results",
                            // ),
                            // TableItem(
                            //   title: "21 Oct 2020",
                            //   value: "Quarterly Results",
                            // ),
                            SizedBox(height: 16),
                            Text('Dividends', style: subtitle1White),
                            SizedBox(height: 26),
                            TableBar(
                              title1: "Type",
                              title2: "Dividend%",
                              title3: "Ex-Dividend date",
                            ),
                            SizedBox(height: 12),
                            ...List.generate(
                              broadcast.corporateAction.dividends.length ?? 0,
                              (i) => TableItem(
                                title: broadcast
                                        .corporateAction.dividends[i].type ??
                                    "",
                                value: broadcast.corporateAction.dividends[i]
                                        .dividendPercent ??
                                    "",
                                remarks: broadcast.corporateAction.dividends[i]
                                        .exDividendDate ??
                                    "",
                              ),
                            ),
                            // TableItem(
                            //   title: "Interim",
                            //   value: "500.00 %",
                            //   remarks: "03 Mar 2020",
                            // ),
                            // TableItem(
                            //   title: "Interim",
                            //   value: "500.00 %",
                            //   remarks: "03 Mar 2020",
                            // ),
                            // TableItem(
                            //   title: "Interim",
                            //   value: "500.00 %",
                            //   remarks: "03 Mar 2020",
                            // ),
                            // TableItem(
                            //   title: "Interim",
                            //   value: "500.00 %",
                            //   remarks: "03 Mar 2020",
                            // ),
                            // TableItem(
                            //   title: "Interim",
                            //   value: "500.00 %",
                            //   remarks: "03 Mar 2020",
                            // ),
                            SizedBox(height: 26),
                            Text('Bonus', style: subtitle1White),
                            SizedBox(height: 26),
                            TableBar(
                              title1: "Ratio",
                              title2: "Announcement date",
                              title3: "Ex-Bonus date",
                            ),
                            SizedBox(height: 12),
                            ...List.generate(
                              broadcast.corporateAction.bonus.length ?? 0,
                              (i) => TableItem(
                                title:
                                    broadcast.corporateAction.bonus[i].ratio ??
                                        "",
                                value: broadcast.corporateAction.bonus[i]
                                        .announcementDate ??
                                    "",
                                remarks: broadcast
                                        .corporateAction.bonus[i].exBonusDate ??
                                    "",
                              ),
                            ),
                            // TableItem(
                            //   title: "1:1",
                            //   value: "26 Jul 2020",
                            //   remarks: "03 Mar 2020",
                            // ),
                            SizedBox(height: 26),
                            Text('Splits', style: subtitle1White),
                            SizedBox(height: 26),
                            TableBar(
                              title1: "Old FV",
                              title2: "New FV",
                              title3: "Ex-Spilt date",
                            ),
                            SizedBox(height: 12),
                            ...List.generate(
                              broadcast.corporateAction.splits.length ?? 0,
                              (i) => TableItem(
                                title:
                                    broadcast.corporateAction.splits[i].oldFv ??
                                        "",
                                value:
                                    broadcast.corporateAction.splits[i].newFv ??
                                        "",
                                remarks: broadcast.corporateAction.splits[i]
                                        .exSplitDate ??
                                    "",
                              ),
                            ),
                            SizedBox(height: 38),
                            Text('Rights', style: subtitle1White),
                            SizedBox(height: 26),
                            TableBar(
                              title1: "Ratio",
                              title2: "Premium",
                              title3: "Ex-Right date",
                            ),
                            SizedBox(height: 12),
                            ...List.generate(
                              broadcast.corporateAction.rights.length ?? 0,
                              (i) => TableItem(
                                title:
                                    broadcast.corporateAction.rights[i].ratio ??
                                        "",
                                value: broadcast
                                        .corporateAction.rights[i].premium ??
                                    "",
                                remarks: broadcast.corporateAction.rights[i]
                                        .exRightDate ??
                                    "",
                              ),
                            ),
                            // TableItem(
                            //   title: "3:7",
                            //   value: "1090",
                            //   remarks: "03 Mar 2020",
                            // ),
                            // TableItem(
                            //   title: "3:7",
                            //   value: "1090",
                            //   remarks: "03 Mar 2020",
                            // ),
                            SizedBox(height: 38),
                            Text('AGM / EGM', style: subtitle1White),
                            SizedBox(height: 26),
                            TableBar(
                              title1: "Date",
                              title2: "Agenda",
                            ),
                            SizedBox(height: 12),
                            ...List.generate(
                              broadcast.corporateAction.agmEgm.length ?? 0,
                              (i) => TableItem(
                                title:
                                    broadcast.corporateAction.agmEgm[i].date ??
                                        "",
                                value: broadcast
                                        .corporateAction.agmEgm[i].agenda ??
                                    "",
                              ),
                            ),
                            // TableItem(
                            //   title: "21 Oct 2020",
                            //   value: " - ",
                            // ),
                            // TableItem(
                            //   title: "21 Oct 2020",
                            //   value: " - ",
                            // ),
                            // TableItem(
                            //   title: "21 Oct 2020",
                            //   value: " - ",
                            // ),
                            // TableItem(
                            //   title: "21 Oct 2020",
                            //   value: " - ",
                            // ),
                          ],
                        ),
                      ),
                    ),
                    // SingleChildScrollView(
                    //   child: Container(
                    //     margin: EdgeInsets.symmetric(horizontal: 16),
                    //     child: Column(
                    //       children: [
                    //         SizedBox(height: 20),
                    //         ...List.generate(
                    //           broadcast.corporateAnnouncement.length ?? 0,
                    //           (i) => NewsArticle(
                    //             title: broadcast
                    //                     .corporateAnnouncement[i].heading ??
                    //                 "",
                    //             date: broadcast
                    //                     .corporateAnnouncement[i].source ??
                    //                 "" +
                    //                     ' - ' +
                    //                     broadcast.corporateAnnouncement[i]
                    //                         .dateTime ??
                    //                 "",
                    //             subtitle: broadcast.corporateAnnouncement[i]
                    //                     .description ??
                    //                 "",
                    //           ),
                    //         ),
                    //         // NewsArticle(
                    //         //   title:
                    //         //       "Bajaj Finance - Announcement under Regulation 30 (LODR)-Analyst / Investor Meet - Intimation",
                    //         //   date: "BSE - 18 Nov 2020, 16:08",
                    //         //   subtitle:
                    //         //       'Pursuant to Regulation 23(9) of the SEBI (Listing Obligations and Disclosure Requirements) Regulations, 2015, as amend-ed, please find enclosed herewith disclosures of related party transactions, on consolidated basis, drawn in accordance with the applicable accounting standards for the half year ended 30 September 2020.',
                    //         // ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    //   ],
                    // ),
                  ),
                ),
              );
  }
}

class _NewsWidgetState extends State<NewsWidget> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Article> articles = [];
  bool isloading = true;
  void getArticles(String title) async {
    articles = await NewsServices.getNewsFromQuery(title).whenComplete(() {
      setState(() {
        isloading = false;
      });
    });
  }

  fetchData() async {
    if (widget.isEtf) {
      await getArticles("ETF news");
    } else if (widget.isIndice) {
      await getArticles('Indices ' + widget.title.replaceAll('S&P', ''));
    } else if (widget.isGlobal) {
      await getArticles(widget.title.replaceAll('derived', ''));
    } else if (widget.isCrypto) {
      await getArticles('Crypto ' + widget.title);
    } else if (widget.isForex) {
      await getArticles('Forex ' + widget.title);
    } else if (widget.isStock) {
      await getArticles(widget.title);
    } else {
      isloading = false;
      articles = widget.articles;
    }
    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return isloading == false
        ? isloading == false && articles == null
            ? NoDataAvailablePage()
            : Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
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
                  // onRefresh: () async {
                  //   await widget.refresh().whenComplete(() {
                  //     _refreshController.refreshCompleted();
                  //   });
                  // },
                  onRefresh: fetchData,
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    addAutomaticKeepAlives: true,
                    itemCount: articles.length,
                    itemBuilder: (BuildContext context, int index) => index == 0
                        ? GridItem(
                            article: articles[index],
                            show: true,
                          )
                        : GridItem(
                            article: articles[index],
                            show: false,
                          ),
                    staggeredTileBuilder: (int index) {
                      return StaggeredTile.count(
                          2, (index + 1) == 1 ? 1.3 : 0.8);
                    },
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                ),
              )
        : LoadingPage();
  }
}
