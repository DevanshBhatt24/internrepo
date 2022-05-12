import 'dart:async';

import 'package:flutter/material.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart' show DateFormat;

///Core theme import
import 'package:syncfusion_flutter_core/theme.dart';

///Map import
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/sampleview.dart';
import 'package:technical_ind/screens/radar/business/radarServices.dart';
import 'package:technical_ind/styles.dart';
import 'package:technical_ind/widgets/appbar_with_back_and_search.dart';

class TradingHoursPage extends SampleView {
  /// Creates the world clock marker map widget
  TradingHoursPage({Key key}) : super(key: key);

  @override
  _TradingHoursPageState createState() => _TradingHoursPageState();
}

class _Cutomtablebar extends StatelessWidget {
  final String title1, title2, title3, title4;
  final bool isextended;

  const _Cutomtablebar(
      {Key key,
      this.title1,
      this.title2,
      this.title3,
      this.title4,
      this.isextended = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _headStyle = captionWhite60;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        color: darkGrey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 7,
                child: Text(
                  title1,
                  style: _headStyle,
                  textAlign: TextAlign.left,
                )),
            Expanded(
                flex: 3,
                child: Text(title2,
                    style: _headStyle,
                    textAlign:
                        title3 == null ? TextAlign.right : TextAlign.center)),
            title3 != null
                ? Expanded(
                    flex: 3,
                    child: Text(title3,
                        style: _headStyle,
                        textAlign: title4 == null
                            ? TextAlign.right
                            : TextAlign.center))
                : Container(),
            title4 != null
                ? Expanded(
                    flex: 3,
                    child: Text(title4,
                        style: _headStyle,
                        textAlign:
                            isextended ? TextAlign.center : TextAlign.right))
                : Container(),
          ],
        ));
  }
}

class _TradingHoursPageState extends SampleViewState {
  // List<_ClockModel> clockModelData;
  bool isinit = true;
  bool isStart = false;
  List<String> status = ["", "", "", "", "", "", ""];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _fetchApi() async {
    var response = await RadarServices.clocktradinghours(
        'https://api.bottomstreet.com/trading_hours');

    if (this.mounted)
      setState(() {
        for (int i = 0; i < response.length; i++) {
          status[i] = response[i]["Status"];
        }
        if (isStart == false) {
          isStart = true;
        }
      });
    _layerController.updateMarkers([0, 1, 2, 3, 4, 5, 6]);
    _refreshController.refreshCompleted();
  }

  Timer _timer;

  List<double> latitude = [
    51.509865,
    52.520008,
    36.778259,
    -35.473469,
    36.204824,
    22.302711,
    31.224361
  ];
  List<double> longitude = [
    -0.118092,
    13.404954,
    -119.417931,
    149.012375,
    138.252924,
    114.177216,
    121.469170
  ];

  List<String> short = ["LSE", "DB", "NASDAQ", "ASE", "JEG", "HSE", "SSE"];

  @override
  void initState() {
    super.initState();
    _fetchApi();
    Future.delayed(Duration(milliseconds: 10000), () {
      _timer = new Timer.periodic(Duration(milliseconds: 5000), (Timer timer) {
        _fetchApi();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWithBack(
          text: "Trading Hours",
        ),
        body: isStart == true
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SmartRefresher(
                  controller: _refreshController,
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
                  enablePullDown: true,
                  enablePullUp: false,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Text('World Stock Market Timing',
                          textAlign: TextAlign.center, style: headline5White),
                      Text('(IST Time)',
                          textAlign: TextAlign.center, style: captionWhite60),
                      Container(child: _getMapsWidget()),
                      SizedBox(height: 24),
                      _Cutomtablebar(
                        title1: "Stock Exchange",
                        title2: "Open Time",
                        title3: "Close Time",
                        isextended: true,
                      ),
                      SizedBox(height: 32),
                      Text('European Markets',
                          textAlign: TextAlign.center, style: subtitle1White),
                      SizedBox(
                        height: 24,
                      ),
                      _buildListItem(
                          "LONDON STOCK\nEXCHANGE",
                          "England",
                          "1:30 pm",
                          "10:00 pm",
                          status[0] == "Open" ? true : false),
                      _buildListItem(
                          'Deutsche Börse'.toUpperCase(),
                          "Germany",
                          "12:30 pm",
                          "2:30 am\n(Next Day)",
                          status[1] == "Open" ? true : false),
                      SizedBox(
                        height: 48,
                      ),
                      Text('American Markets',
                          textAlign: TextAlign.center, style: subtitle1White),
                      SizedBox(
                        height: 36,
                      ),
                      _buildListItem(
                          'NASDAQ',
                          "USA",
                          "7:00 pm",
                          "1:30 am\n(Next Day)",
                          status[2] == "Open" ? true : false),
                      SizedBox(
                        height: 48,
                      ),
                      Text('Asian Markets',
                          textAlign: TextAlign.center, style: subtitle1White),
                      SizedBox(
                        height: 36,
                      ),
                      _buildListItem(
                          'AUSTRALIAN\nSECURITY EXCHANGE',
                          "Australia",
                          "5:30 am",
                          "11:30 am",
                          status[3] == "Open" ? true : false),
                      _buildListItem(
                          'JAPAN EXCHANGE\nGROUP',
                          "Japan",
                          "5:30 am",
                          "11:30 am",
                          status[4] == "Open" ? true : false),
                      _buildListItem(
                          'HONGKONG STOCK\nEXCHANGE',
                          "Hong Kong",
                          "6:45 am",
                          "1:30 pm",
                          status[5] == "Open" ? true : false),
                      _buildListItem(
                          'SHANGHAI STOCK\nEXCHANGE',
                          "China",
                          "7:00 am",
                          "12:30 pm",
                          status[5] == "Open" ? true : false),
                    ],
                  ),
                ),
              )
            : LoadingPage());
  }

  Widget _buildListItem(String countryname, String country, String open,
      String close, bool status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: status ? blue : red,
                    shape: BoxShape.circle,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(countryname,
                        overflow: TextOverflow.ellipsis, style: subtitle2White),
                    Text(country, style: captionWhite60)
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child:
                Text(open, textAlign: TextAlign.center, style: subtitle2White),
          ),
          Expanded(
            flex: 3,
            child: Text(close, textAlign: TextAlign.end, style: subtitle2White),
          )
        ],
      ),
    );
  }

  final MapShapeLayerController _layerController = MapShapeLayerController();

  Widget _getMapsWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(4),
        child: SfMapsTheme(
          data: SfMapsThemeData(
            shapeHoverColor: Colors.transparent,
            shapeHoverStrokeColor: Colors.transparent,
            shapeHoverStrokeWidth: 0,
          ),
          child: SfMaps(
            layers: <MapLayer>[
              MapShapeLayer(
                  controller: _layerController,
                  loadingBuilder: (BuildContext context) {
                    return Container(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    );
                  },
                  source: MapShapeSource.asset(
                    'assets/world_map.json',
                    shapeDataField: 'name',
                  ),
                  initialMarkersCount: 7,
                  markerBuilder: (_, int index) {
                    List<int> l = [1, 3, 4, 5];
                    return MapMarker(
                        longitude: longitude[index],
                        latitude: latitude[index],
                        iconColor: status[index] == "Open" ? blue : red,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(l.contains(index) ? '' : short[index],
                                  style: overline),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: status[index] == "Open" ? blue : red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text(l.contains(index) ? short[index] : '',
                                  style: overline),
                            ],
                          ),
                        ),
                        size: Size(60, 70));
                  },
                  strokeWidth: 1,
                  strokeColor: Color(0xff999999),
                  color: Color(0xff999999)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // clockModelData?.clear();
    _timer.cancel();
    _refreshController.dispose();
    super.dispose();
  }
}
