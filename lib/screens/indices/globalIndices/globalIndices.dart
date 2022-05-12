import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/containPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/News/broadcastPage.dart';
import 'package:technical_ind/screens/chartScreen.dart';
import 'package:technical_ind/screens/commodity/historycommo.dart';
import 'package:technical_ind/screens/cryptocurrency/indicatorsPage.dart';
import 'package:technical_ind/screens/indices/business/indices_services.dart';
import 'package:technical_ind/screens/indices/globalIndices/globalIndicesComponents.dart';
import 'package:technical_ind/screens/indices/globalIndices/globalOverview.dart';

import '../../../components/cardFinal.dart';
import '../../../styles.dart';
import '../../../widgets/item.dart';
import '../business/indices_global_model.dart';
import 'global_explore.dart';

import 'dart:convert';

class GlobalIndices extends StatefulWidget {
  GlobalIndices();
  @override
  _GlobalIndicesState createState() => _GlobalIndicesState();
}

class _GlobalIndicesState extends State<GlobalIndices> {
  var jsonText;
  bool isloading = true;
  List<GlobalIcon> globalIcons;
  _loadData() async {
    jsonText =
        await rootBundle.loadString('assets/instrument/globalIndices.json');
    globalIcons = globalIconFromJson(jsonText);
  }

  IndicesGlobalModel indicesGlobalModel;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  var crossAxisCount;
  @override
  void initState() {
    super.initState();
    _loadData();
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

  _fetchApi() async {
    indicesGlobalModel = await IndicesServices.getGlobalList();
    indicesGlobalModel.data
        .removeWhere((element) => nonevalues.contains(element.name));

    indicesGlobalModel.data.removeWhere((element) =>
        element.name == 'S&P 500 VIX' ||
        element.name == 'DJ New Zealand' ||
        element.name == 'PSEi Composite' ||
        element.name == 'Karachi 100' ||
        element.name == 'VN 30');
    setState(() {
      isloading = false;
    });
    _refreshController.refreshCompleted();
  }

  List<String> nonevalues = ['Nifty 50', 'BSE Sensex'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? LoadingPage()
          : indicesGlobalModel == null
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
                          childAspectRatio: 0.91,
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          children: List.generate(
                            indicesGlobalModel.data.length,
                            (index) {
                              return section(
                                index,
                                context,
                                indicesGlobalModel.data[index].name,
                                indicesGlobalModel.data[index].last,
                                indicesGlobalModel.data[index].chg,
                                indicesGlobalModel.data[index].datumChg,
                                indicesGlobalModel.data[index].high,
                                indicesGlobalModel.data[index].low,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  InkWell section(
    int index,
    BuildContext context,
    String name,
    String last,
    String chg,
    String chgpercent,
    String high,
    String low,
  ) {
    String code = 'none';
    String countryName = 'none';
    for (var ele in globalIcons) {
      if (ele.globalIndicesName == name.replaceAll('derived', '')) {
        code = ele.countryCode;
        countryName = ele.countryName;
      }
    }
    return InkWell(
      onTap: () {
        var query = name.replaceAll('&', 'and');
        pushNewScreen(
          context,
          withNavBar: false,
          screen: ContainPage(
            query: query,
            isListGlobal: true,
            menu: [
              'Overview',
              'Charts',
              'Components',
              'Technical Indicators',
              // 'Historical Data',
              'News'
            ],
            menuWidgets: [
              GlobalOverview(
                query: query,
                price: last,
                chng: chg + ' (' + chgpercent + ')',
                // overview: gobalOverview.overview,
              ),
              ChartScreen(
                isIndice: true,
                companyName: name.replaceAll('derived', ''),
                isUsingWeb: true,
                presentInSymbols: true,
              ),
              GlobalIndicesCompoments(
                query: query,
                // component: gobalOverview.components,
              ),
              IndicatorPage(
                query: query,
                isGlobalIndices: true,
                // indicator: gobalOverview.technicalIndicator,
              ),
              // HistoryPageCommodity(
              //   query: query,
              //   isGlobalIndices: true,
              //   // historicalData: gobalOverview.historicalData,
              // ),
              NewsWidget(
                isGlobal: true,
                title: name.replaceAll('derived', ''),
              ),
            ],
            title: name.replaceAll('derived', ''),
            defaultWidget: "Overview",
          ),
          // screen: ExplorePageGlobal(
          //   menu: [
          //     'Overview',
          //     'Charts',
          //     'Components',
          //     'Technical Indicators',
          //     'Historical Data',
          //     'News'
          //   ],
          //   mid: Column(
          //     children: [
          //       SizedBox(height: 12),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Container(
          //             height: 11,
          //             width: 20,
          //             child: Image.asset(
          //                 'icons/flags/png/${code.toLowerCase()}.png',
          //                 package: 'country_icons'),
          //           ),
          //           Container(
          //             child: Text('  ' + countryName, style: bodyText2White),
          //           )
          //         ],
          //       )
          //     ],
          //   ),
          //   title: name,
          //   value: last,
          //   subValue: chg + ' (' + chgpercent + ')',
          // ),
        );
      },
      child: CardGridItem(
        // aspectRatio: 0.96,
        title: name.replaceAll('derived', ''),
        value: last,
        subvalue: chg + ' (' + chgpercent + ')',
        color: chg[0] == '-' ? red : blue,
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 11,
              width: 20,
              child: Image.asset('icons/flags/png/${code.toLowerCase()}.png',
                  package: 'country_icons'),
            ),
            Container(
              child: Text('  ' + countryName, style: captionWhite),
            )
          ],
        ),
        items: [
          RowItem("High", high, pad: 3),
          RowItem("Low", low, pad: 3),
        ],
        isGlobal: true,
      ),
    );
  }
}

// To parse this JSON data, do
//
//     final globalIcon = globalIconFromJson(jsonString);

List<GlobalIcon> globalIconFromJson(String str) =>
    List<GlobalIcon>.from(json.decode(str).map((x) => GlobalIcon.fromJson(x)));

String globalIconToJson(List<GlobalIcon> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GlobalIcon {
  GlobalIcon({
    this.globalIndicesName,
    this.countryName,
    this.countryCode,
  });

  String globalIndicesName;
  String countryName;
  String countryCode;

  factory GlobalIcon.fromJson(Map<String, dynamic> json) => GlobalIcon(
        globalIndicesName: json["Global Indices Name"],
        countryName: json["Country Name"],
        countryCode: json["Country Code"],
      );

  Map<String, dynamic> toJson() => {
        "Global Indices Name": globalIndicesName,
        "Country Name": countryName,
        "Country Code": countryCode,
      };
}
