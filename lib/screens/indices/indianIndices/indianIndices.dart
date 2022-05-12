import 'package:flutter/material.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/containPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/News/broadcastPage.dart';
import 'package:technical_ind/screens/chartScreen.dart';
import 'package:technical_ind/screens/commodity/historycommo.dart';
import 'package:technical_ind/screens/cryptocurrency/indicatorsPage.dart';
import 'package:technical_ind/screens/indices/business/indices_services.dart';
import 'package:technical_ind/screens/indices/indianIndices/indianIndicesComponents.dart';
import 'package:technical_ind/screens/indices/indianIndices/overview_indian.dart';
import 'package:technical_ind/screens/indices/indianIndices/stockEffect.dart';
import '../../../styles.dart';
import '../../../widgets/card.dart';
import '../../../widgets/item.dart';
import '../mcxIndices/mcxIndices.dart';
import '../business/indices_nse_model.dart';
import '../business/indices_mcx_model.dart';

class IndianIndices extends StatefulWidget {
  @override
  _IndianIndicesState createState() => _IndianIndicesState();
}

class _IndianIndicesState extends State<IndianIndices> {
  IndicesNseModel indicesBseModel;
  IndicesNseModel indicesNseModel;
  IndicesMcxModel indicesMcxModel;
  bool loading = true;

  _fetchApi() async {
    var nselist = await IndicesServices.getNseList();
    var bselist = await IndicesServices.getBseList();
    var mcxlist = await IndicesServices.getMcxList();
    indicesBseModel = bselist[0];
    indicesNseModel = nselist[0];
    indicesMcxModel = mcxlist[0];
    setState(() {
      loading = false;
    });
    _refreshController.refreshCompleted();
  }

  List<String> menu = [
    'Overview',
    'Charts',
    'Stock Effect',
    'Components',
    'Technical Indicators',
    // 'Historical Data',
    'News'
  ];

  // List<String> menu2 = [
  //   'Overview',
  //   'Charts',
  //   'Stock Effect',
  //   'Components',
  //   'Technical Indicators',
  //   'Historical Data',
  //   'F & O',
  //   'News'
  // ];

  int crossAxisCount = 2;
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // appBar: AppBarWithBack(text: "Indian Indices",height:40.h),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
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
                  Tab(
                    text: "BSE",
                  ),
                  Tab(
                    text: "NSE",
                    //child: NSEtab(),
                  ),
                  Tab(
                    text: "MCX",
                  ),
                ],
              ),
            ],
          ),
        ),
        body: loading
            ? LoadingPage()
            : indicesBseModel == null
                ? NoDataAvailablePage()
                : Padding(
                    padding: EdgeInsets.only(
                        top: 18, left: 16, right: 16, bottom: 55),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < 600)
                          crossAxisCount = 2;
                        else {
                          crossAxisCount = 4;
                        }
                        return TabBarView(
                          children: [
                            _indicesBse(context, indicesBseModel, 1),
                            _indicesNse(context, indicesNseModel, 2),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SmartRefresher(
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
                                onRefresh: () => _fetchApi(),
                                child: indicesMcxModel.data.length == 0
                                    ? NoDataAvailablePage()
                                    : SingleChildScrollView(
                                        child: MCXIndices(
                                          indicesMcxModel: indicesMcxModel,
                                        ),
                                      ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
      ),
    );
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Widget _indicesBse(
      BuildContext context, IndicesNseModel indicesBseModel, int number) {
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
        childAspectRatio: 0.89,
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(
          indicesBseModel.data.length,
          (i) {
            return StockCard(
              onTap: () {
                var title = indicesBseModel?.data[i]?.name ?? "";
                var query = title.replaceAll('&', 'and');
                pushNewScreen(
                  context,
                  withNavBar: false,
                  screen: ContainPage(
                    query: query,
                    isList: true,
                    title: indicesBseModel?.data[i]?.name ?? "",
                    menu: menu,
                    defaultWidget: menu[0],
                    menuWidgets: [
                      OverviewIndianIndices(
                        query: query,
                        price: indicesBseModel?.data[i]?.currentValue ?? "",
                        chng: !indicesBseModel?.data[i]?.change.contains('-')
                            ? '+' +
                                indicesBseModel.data[i].datumChange +
                                ' (+' +
                                indicesBseModel.data[i].change +
                                '%)'
                            : indicesBseModel.data[i].datumChange +
                                ' (' +
                                indicesBseModel.data[i].change +
                                '%)',
                        // overview: indianOverviewModel.overview,
                      ),
                      ChartScreen(
                        isIndice: true,
                        companyName: title,
                        isUsingWeb: true,
                        presentInSymbols: true,
                      ),
                      StockEffect(
                        query: query,
                        // stockEffects: indianOverviewModel.stockEffect,
                      ),
                      IndianIndicesComponents(
                        query: query,
                      ),
                      IndicatorPage(
                        query: query, isIndianIndices: true,
                        // indicator:
                        //     indianOverviewModel.technicalIndicator,
                      ),
                      HistoryPageCommodity(
                        query: query, isIndianIndices: true,
                        // historicalData:
                        //     indianOverviewModel.historicalData,
                      ),
                      NewsWidget(
                        isIndice: true,
                        title: title,
                      ),
                    ],
                  ),
                );
              },
              title: indicesBseModel?.data[i].name.replaceAll('S&P', '') ?? "",
              price: indicesBseModel?.data[i].currentValue ?? "",
              highlight: indicesBseModel?.data[i]?.change[0] != '-'
                  ? '+' +
                      indicesBseModel?.data[i]?.datumChange +
                      ' (+' +
                      indicesBseModel?.data[i]?.change +
                      '%)'
                  : indicesBseModel?.data[i].datumChange +
                      ' (' +
                      indicesBseModel.data[i].change +
                      '%)',
              color: indicesBseModel?.data[i]?.change[0] != '-' ? blue : red,
              list: [
                RowItem(
                  "Open",
                  indicesBseModel?.data[i]?.open ?? "",
                  fontsize: 14,
                  pad: 3,
                ),
                RowItem(
                  "High",
                  indicesBseModel?.data[i]?.high ?? "",
                  fontsize: 14,
                  pad: 3,
                ),
                RowItem(
                  "Low",
                  indicesBseModel?.data[i]?.low ?? "",
                  fontsize: 14,
                  pad: 3,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _indicesNse(
      BuildContext context, IndicesNseModel indicesNseModel, int number) {
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
        childAspectRatio: 0.89,
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(
          indicesNseModel.data.length,
          (i) {
            if (i == 0) {
              var title = indicesNseModel?.data[0]?.name ?? "";
              var query = title.replaceAll('&', 'and');
              return StockCard(
                onTap: () {
                  pushNewScreen(context,
                      withNavBar: false,
                      screen: ContainPage(
                        title: indicesNseModel?.data[0]?.name ?? "",
                        menu: menu,
                        defaultWidget: menu[0],
                        menuWidgets: [
                          OverviewIndianIndices(
                            query: query,
                            price: indicesNseModel?.data[0]?.currentValue ?? "",
                            chng:
                                !indicesNseModel?.data[0]?.change.contains('-')
                                    ? '+' +
                                        indicesNseModel.data[0].datumChange +
                                        ' (+' +
                                        indicesNseModel.data[0].change +
                                        '%)'
                                    : indicesNseModel.data[0].datumChange +
                                        ' (' +
                                        indicesNseModel.data[0].change +
                                        '%)',
                            // overview: indianOverviewModel.overview,
                          ),
                          ChartScreen(
                            isIndice: true,
                            companyName: title,
                            isUsingWeb: true,
                            presentInSymbols: true,
                          ),
                          StockEffect(
                            query: query,
                            // stockEffects: indianOverviewModel.stockEffect,
                          ),
                          IndianIndicesComponents(
                            query: query,
                          ),
                          IndicatorPage(
                            query: query, isIndianIndices: true,
                            // indicator:
                            //     indianOverviewModel.technicalIndicator,
                          ),
                          HistoryPageCommodity(
                            query: query, isIndianIndices: true,
                            // historicalData:
                            //     indianOverviewModel.historicalData,
                          ),
                          NewsWidget(
                            isIndice: true,
                            title: title,
                          ),
                        ],
                      ));
                },
                title: indicesNseModel?.data[0]?.name ?? "",
                price: indicesNseModel?.data[0]?.currentValue ?? "",
                highlight: indicesNseModel?.data[0]?.change[0] != '-'
                    ? '+' +
                        indicesNseModel?.data[0]?.datumChange +
                        ' (+' +
                        indicesNseModel?.data[0]?.change +
                        '%)'
                    : indicesNseModel?.data[0].datumChange +
                        ' (' +
                        indicesNseModel?.data[0]?.change +
                        '%)',
                color: indicesNseModel?.data[0]?.change[0] != '-' ? blue : red,
                list: [
                  RowItem(
                    "Open",
                    indicesNseModel?.data[0]?.open ?? "",
                    fontsize: 14,
                    pad: 3,
                  ),
                  RowItem(
                    "High",
                    indicesNseModel?.data[0]?.high ?? "",
                    fontsize: 14,
                    pad: 3,
                  ),
                  RowItem(
                    "Low",
                    indicesNseModel?.data[0]?.low ?? "",
                    fontsize: 14,
                    pad: 3,
                  ),
                ],
              );
            } else if (i == 1) {
              return StockCard(
                onTap: () {
                  var title = indicesNseModel?.data[7]?.name ?? "";
                  var query = title.replaceAll('&', 'and');
                  pushNewScreen(context,
                      withNavBar: false,
                      screen: ContainPage(
                        title: indicesNseModel?.data[7]?.name ?? "",
                        menu: menu,
                        defaultWidget: menu[0],
                        menuWidgets: [
                          OverviewIndianIndices(
                            query: query,
                            price: indicesNseModel?.data[7]?.currentValue ?? "",
                            chng:
                                !indicesNseModel?.data[7]?.change.contains('-')
                                    ? '+' +
                                        indicesNseModel.data[7].datumChange +
                                        ' (+' +
                                        indicesNseModel.data[7].change +
                                        '%)'
                                    : indicesNseModel.data[7].datumChange +
                                        ' (' +
                                        indicesNseModel.data[7].change +
                                        '%)',
                            // overview: indianOverviewModel.overview,
                          ),
                          ChartScreen(
                            isIndice: true,
                            companyName: title,
                            isUsingWeb: true,
                            presentInSymbols: true,
                          ),
                          StockEffect(
                            query: query,
                            // stockEffects: indianOverviewModel.stockEffect,
                          ),
                          IndianIndicesComponents(
                            query: query,
                          ),
                          IndicatorPage(
                            query: query, isIndianIndices: true,
                            // indicator:
                            //     indianOverviewModel.technicalIndicator,
                          ),
                          HistoryPageCommodity(
                            query: query, isIndianIndices: true,
                            // historicalData:
                            //     indianOverviewModel.historicalData,
                          ),
                          NewsWidget(
                            isIndice: true,
                            title: title,
                          ),
                        ],
                      ));
                },
                title: indicesNseModel?.data[7]?.name ?? "",
                price: indicesNseModel?.data[7]?.currentValue ?? "",
                highlight: indicesNseModel?.data[7]?.change[0] != '-'
                    ? '+' +
                        indicesNseModel?.data[7]?.datumChange +
                        ' (+' +
                        indicesNseModel?.data[7]?.change +
                        '%)'
                    : indicesNseModel?.data[7].datumChange +
                        ' (' +
                        indicesNseModel?.data[7]?.change +
                        '%)',
                color: indicesNseModel?.data[7]?.change[0] != '-' ? blue : red,
                list: [
                  RowItem(
                    "Open",
                    indicesNseModel?.data[7]?.open ?? "",
                    fontsize: 14,
                    pad: 3,
                  ),
                  RowItem(
                    "High",
                    indicesNseModel?.data[7]?.high ?? "",
                    fontsize: 14,
                    pad: 3,
                  ),
                  RowItem(
                    "Low",
                    indicesNseModel?.data[7]?.low ?? "",
                    fontsize: 14,
                    pad: 3,
                  ),
                ],
              );
            } else if (i == 7) {
              var title = indicesNseModel?.data[1]?.name ?? "";
              var query = title.replaceAll('&', 'and');
              return StockCard(
                onTap: () {
                  pushNewScreen(context,
                      withNavBar: false,
                      screen: ContainPage(
                        title: indicesNseModel?.data[1]?.name ?? "",
                        menu: menu,
                        defaultWidget: menu[0],
                        menuWidgets: [
                          OverviewIndianIndices(
                            query: query,
                            price: indicesNseModel?.data[1]?.currentValue ?? "",
                            chng:
                                !indicesNseModel?.data[1]?.change.contains('-')
                                    ? '+' +
                                        indicesNseModel.data[1].datumChange +
                                        ' (+' +
                                        indicesNseModel.data[1].change +
                                        '%)'
                                    : indicesNseModel.data[1].datumChange +
                                        ' (' +
                                        indicesNseModel.data[1].change +
                                        '%)',
                            // overview: indianOverviewModel.overview,
                          ),
                          ChartScreen(
                            isIndice: true,
                            companyName: title,
                            isUsingWeb: true,
                            presentInSymbols: true,
                          ),
                          StockEffect(
                            query: query,
                            // stockEffects: indianOverviewModel.stockEffect,
                          ),
                          IndianIndicesComponents(
                            query: query,
                          ),
                          IndicatorPage(
                            query: query, isIndianIndices: true,
                            // indicator:
                            //     indianOverviewModel.technicalIndicator,
                          ),
                          HistoryPageCommodity(
                            query: query, isIndianIndices: true,
                            // historicalData:
                            //     indianOverviewModel.historicalData,
                          ),
                          NewsWidget(
                            isIndice: true,
                            title: title,
                          ),
                        ],
                      ));
                },
                title: indicesNseModel?.data[1]?.name ?? "",
                price: indicesNseModel?.data[1]?.currentValue ?? "",
                highlight: indicesNseModel?.data[1]?.change[0] != '-'
                    ? '+' +
                        indicesNseModel?.data[1]?.datumChange +
                        ' (+' +
                        indicesNseModel?.data[1]?.change +
                        '%)'
                    : indicesNseModel?.data[1].datumChange +
                        ' (' +
                        indicesNseModel?.data[1]?.change +
                        '%)',
                color: indicesNseModel?.data[1]?.change[0] != '-' ? blue : red,
                list: [
                  RowItem(
                    "Open",
                    indicesNseModel?.data[1]?.open ?? "",
                    fontsize: 14,
                    pad: 3,
                  ),
                  RowItem(
                    "High",
                    indicesNseModel?.data[1]?.high ?? "",
                    fontsize: 14,
                    pad: 3,
                  ),
                  RowItem(
                    "Low",
                    indicesNseModel?.data[1]?.low ?? "",
                    fontsize: 14,
                    pad: 3,
                  ),
                ],
              );
            }
            var title = indicesNseModel?.data[i]?.name ?? "";
            var query = title.replaceAll('&', 'and');
            return StockCard(
              onTap: () {
                pushNewScreen(context,
                    withNavBar: false,
                    screen: ContainPage(
                      title: indicesNseModel?.data[i]?.name ?? "",
                      menu: menu,
                      defaultWidget: menu[0],
                      menuWidgets: [
                        OverviewIndianIndices(
                          query: query,
                          price: indicesNseModel?.data[i]?.currentValue ?? "",
                          chng: !indicesNseModel?.data[i]?.change.contains('-')
                              ? '+' +
                                  indicesNseModel.data[i].datumChange +
                                  ' (+' +
                                  indicesNseModel.data[i].change +
                                  '%)'
                              : indicesNseModel.data[i].datumChange +
                                  ' (' +
                                  indicesNseModel.data[i].change +
                                  '%)',
                          // overview: indianOverviewModel.overview,
                        ),
                        ChartScreen(
                          isIndice: true,
                          companyName: title,
                          isUsingWeb: true,
                          presentInSymbols: true,
                        ),
                        StockEffect(
                          query: query,
                          // stockEffects: indianOverviewModel.stockEffect,
                        ),
                        IndianIndicesComponents(
                          query: query,
                        ),
                        IndicatorPage(
                          query: query, isIndianIndices: true,
                          // indicator:
                          //     indianOverviewModel.technicalIndicator,
                        ),
                        HistoryPageCommodity(
                          query: query, isIndianIndices: true,
                          // historicalData:
                          //     indianOverviewModel.historicalData,
                        ),
                        NewsWidget(
                          isIndice: true,
                          title: title,
                        ),
                      ],
                    ));
              },
              title: indicesNseModel?.data[i]?.name ?? "",
              price: indicesNseModel?.data[i]?.currentValue ?? "",
              highlight: indicesNseModel?.data[i]?.change[0] != '-'
                  ? '+' +
                      indicesNseModel?.data[i]?.datumChange +
                      ' (+' +
                      indicesNseModel?.data[i]?.change +
                      '%)'
                  : indicesNseModel?.data[i].datumChange +
                      ' (' +
                      indicesNseModel?.data[i]?.change +
                      '%)',
              color: indicesNseModel?.data[i]?.change[0] != '-' ? blue : red,
              list: [
                RowItem(
                  "Open",
                  indicesNseModel?.data[i]?.open ?? "",
                  fontsize: 14,
                  pad: 3,
                ),
                RowItem(
                  "High",
                  indicesNseModel?.data[i]?.high ?? "",
                  fontsize: 14,
                  pad: 3,
                ),
                RowItem(
                  "Low",
                  indicesNseModel?.data[i]?.low ?? "",
                  fontsize: 14,
                  pad: 3,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
