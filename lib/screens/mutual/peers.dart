import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:technical_ind/components/slidePanel.dart';
import '../etf/business/models/etf_explore_model.dart';
import '../../styles.dart';
import '../../widgets/datagrid.dart';

class BubbleChartData {
  String name;
  double x, y;
  Color color;
  double size;

  BubbleChartData({this.name, this.color, this.size, this.x, this.y});
}

class PeersMutualFunds extends StatefulWidget {
  final Fundvspeer fundvspeer;
  final String latestNav, title;
  final Widget end;
  final MutualPriceDetails mutualFundPriceDetails;
  PeersMutualFunds(
      {Key key,
      this.end,
      this.fundvspeer,
      this.latestNav,
      this.title,
      this.mutualFundPriceDetails})
      : super(key: key);

  @override
  _PeersMutualFundsState createState() => _PeersMutualFundsState();
}

class _PeersMutualFundsState extends State<PeersMutualFunds> {
  Fundvspeer fundvspeer;
  List<BubbleChartData> chartData = [];
  List<String> menu1 = ["Cumulative", "Sip-Return"];

  String defaultWidget = "";

  List<dynamic> color = [
    Color(0xff5e5ce6),
    Color(0xffffac2b).withOpacity(0.6),
    red,
    Color(0xff32d74b),
    Color(0xffe58bff)
  ];
  _initializeChart() {
    for (int i = 0; i < fundvspeer.riskReturnMatrix.length; i++) {
      chartData.add(
        BubbleChartData(
            name: fundvspeer.riskReturnMatrix[i].schemeName,
            x: double.parse(fundvspeer.riskReturnMatrix[i].riskPercent),
            y: double.parse(fundvspeer.riskReturnMatrix[i].riskPercent),
            size: 1,
            color: color[i]),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fundvspeer = widget.fundvspeer;
    // _initializeChart();
    defaultWidget = menu1[_s1];
  }

  PanelController _panelController = PanelController();
  int _s1 = 0;

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    List<String> titleSplitted = [];

    return SlidePanel(
      menu: menu1,
      panelController: _panelController,
      defaultWidget: defaultWidget,
      onChange: (val) {
        setState(() {
          _s1 = val;
        });
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                  decoration: BoxDecoration(
                    color: darkGrey,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      titleSplitted.length == 0
                          ? Text(widget.title,
                              textAlign: TextAlign.center,
                              style: subtitle1White)
                          : Text(
                              titleSplitted[0] + "\n -" + titleSplitted[1] ??
                                  "",
                              textAlign: TextAlign.center,
                              style: subtitle1White),
                      SizedBox(
                        height: 8,
                      ),
                      if (widget.latestNav != null) ...[
                        Text("UNRATED"),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Latest Nav", style: captionWhite),
                        Text('${widget.latestNav}', style: bodyText1white),
                      ],
                      if (widget.end != null) widget.end,
                      SizedBox(
                        height: 5,
                      ),
                      if (widget.mutualFundPriceDetails != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.mutualFundPriceDetails.chng),
                            Text(
                                '(${widget.mutualFundPriceDetails.chngPercentage})')
                          ],
                        )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                buildInkWell(),
                SizedBox(height: 10),
                if (_s1 == 0)
                  ...List.generate(
                    fundvspeer.peersComparison.cumulative.length,
                    (index) => Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: _text(fundvspeer
                                  .peersComparison.cumulative[index].name)),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('NAV', style: bodyText2White60),
                                  SizedBox(height: 5),
                                  Text(
                                    fundvspeer
                                        .peersComparison.cumulative[index].nav,
                                    style: bodyText1white,
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('AUM', style: bodyText2White60),
                                  SizedBox(height: 5),
                                  Text(
                                      fundvspeer.peersComparison
                                          .cumulative[index].aum,
                                      style: subtitle1profileblue)
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('1M', style: bodyText2White60),
                                  SizedBox(height: 5),
                                  Text(
                                      fundvspeer.peersComparison
                                          .cumulative[index].oneMonth,
                                      style: subtitle1profileblue)
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('1 Yr', style: bodyText2White60),
                                  SizedBox(height: 5),
                                  Text(
                                      fundvspeer.peersComparison
                                          .cumulative[index].oneYr,
                                      style: subtitle1profileblue)
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('3 Yr', style: bodyText2White60),
                                  SizedBox(height: 5),
                                  Text(
                                      fundvspeer.peersComparison
                                          .cumulative[index].threeYr,
                                      style: subtitle1profileblue)
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('5 Yr', style: bodyText2White60),
                                  SizedBox(height: 5),
                                  Text(
                                      fundvspeer.peersComparison
                                          .cumulative[index].fiveYr,
                                      style: subtitle1profileblue)
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                if (_s1 == 1)
                  ...List.generate(
                    fundvspeer.peersComparison.sipReturn.length,
                    (index) => Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: _text(fundvspeer
                                  .peersComparison.sipReturn[index].name)),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('NAV', style: bodyText2White60),
                                  SizedBox(height: 5),
                                  Text(
                                    fundvspeer
                                        .peersComparison.sipReturn[index].nav,
                                    style: bodyText1white,
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('AUM', style: bodyText2White60),
                                  SizedBox(height: 5),
                                  Text(
                                      fundvspeer
                                          .peersComparison.sipReturn[index].aum,
                                      style: subtitle1profileblue)
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('1M', style: bodyText2White60),
                                  SizedBox(height: 5),
                                  Text(
                                      fundvspeer.peersComparison
                                          .sipReturn[index].oneMonth,
                                      style: subtitle1profileblue)
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('1 Yr', style: bodyText2White60),
                                  SizedBox(height: 5),
                                  Text(
                                      fundvspeer.peersComparison
                                          .sipReturn[index].oneYr,
                                      style: subtitle1profileblue)
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('3 Yr', style: bodyText2White60),
                                  SizedBox(height: 5),
                                  Text(
                                      fundvspeer.peersComparison
                                          .sipReturn[index].threeYr,
                                      style: subtitle1profileblue)
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('5 Yr', style: bodyText2White60),
                                  SizedBox(height: 5),
                                  Text(
                                      fundvspeer.peersComparison
                                          .sipReturn[index].fiveYr,
                                      style: subtitle1profileblue)
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                SizedBox(height: 38),
                _text("Risk Return Matrix"),
                // SizedBox(height: 26),
                // AspectRatio(
                //     aspectRatio: 1.1,
                //     child: Container(child: _getPointColorBubbleChart())),

                SizedBox(height: 15),

                Container(
                  height: fundvspeer.riskReturnMatrix.length * 100.0,
                  width: 1 * MediaQuery.of(context).size.width,
                  child: CustomTable(
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    fixedColumnWidth: 0.37 * MediaQuery.of(context).size.width,
                    columnwidth: 0.27 * MediaQuery.of(context).size.width,
                    headersTitle: ["Company", "Return (%)", "Risk (%)"],
                    totalColumns: 3,
                    itemCount: fundvspeer.riskReturnMatrix.length,
                    leftSideItemBuilder: (c, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(fundvspeer.riskReturnMatrix[i].schemeName,
                            style: bodyText2White),
                      );
                    },
                    rightSideItemBuilder: (c, i) {
                      return DataTableItem(
                        height: 66,
                        data: [
                          fundvspeer.riskReturnMatrix[i].returnPercent,
                          fundvspeer.riskReturnMatrix[i].riskPercent,
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell buildInkWell() {
    return InkWell(
      onTap: () {
        setState(() {
          defaultWidget = menu1[_s1];
        });

        _panelController.open();
      },
      child: Container(
          //width: 150.w,
          // margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
              color: darkGrey, borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(menu1[_s1].toUpperCase(), style: bodyText2White60),
              Icon(
                Icons.keyboard_arrow_down,
                color: almostWhite,
              )
            ],
          )),
    );
  }

  SfCartesianChart _getPointColorBubbleChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      enableAxisAnimation: true,
      primaryXAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(color: Colors.transparent),
          labelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: almostWhite,
          ),
          majorTickLines: MajorTickLines(width: 0),
          title: AxisTitle(
            text: 'Risk (%)',
            textStyle: TextStyle(
              fontSize: 12,
              color: white60,
            ),
          ),
          minimum: 0,
          maximum: 100),
      primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(color: Colors.transparent),
          labelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: almostWhite,
          ),
          majorTickLines: MajorTickLines(width: 0),
          title: AxisTitle(
            text: 'Return (%)',
            textStyle: TextStyle(
              fontSize: 12,
              color: white60,
            ),
          ),
          minimum: 0,
          maximum: 100),
      onTooltipRender: (ta) {
        ta.header = chartData[ta.pointIndex].name;
      },
      series: _getPointColorBubbleSeries(),
      tooltipBehavior: TooltipBehavior(
        tooltipPosition: TooltipPosition.pointer,
        textAlignment: ChartAlignment.center,
        enable: true,
        canShowMarker: true,
        color: grey,
        textStyle: TextStyle(
          fontSize: 10,
          color: almostWhite,
        ),
        format: 'Risk(%) point.x%\nreturn(%) point.y%',
      ),
    );
  }

  /// Returns the list of chart series which need to render on the bubble chart
  List<BubbleSeries<BubbleChartData, num>> _getPointColorBubbleSeries() {
    return <BubbleSeries<BubbleChartData, num>>[
      BubbleSeries<BubbleChartData, num>(
        dataSource: chartData,
        opacity: 0.8,
        xValueMapper: (BubbleChartData sales, _) => sales.x,
        yValueMapper: (BubbleChartData sales, _) => sales.y,
        dataLabelMapper: (BubbleChartData sales, _) => sales.name,
        pointColorMapper: (BubbleChartData sales, _) => sales.color,
        sizeValueMapper: (BubbleChartData sales, _) => sales.size,
      )
    ];
  }

  Widget _text(String t) {
    return Align(
      alignment: Alignment.center,
      child: new Text(t, style: subtitle1White, textAlign: TextAlign.center),
    );
  }
}
