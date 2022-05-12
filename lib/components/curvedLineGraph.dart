import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../screens/etf/business/models/etf_summary_model.dart';
import 'package:intl/intl.dart';
import '../styles.dart';

class CurvedLineGraph extends StatefulWidget {
  final List<Datum> arr;
  CurvedLineGraph({this.arr});
  @override
  _CurvedLineGraphState createState() => _CurvedLineGraphState();
}

/// Private class for storing the spline series data points.
class _ChartData {
  final double x;

  final double y;
  _ChartData(this.x, this.y);
}

class _CurvedLineGraphState extends State<CurvedLineGraph> {
  SplineType _spline = SplineType.natural;

  @override
  Widget build(BuildContext context) {
    return _getTypesSplineChart();
  }

  List<_ChartData> _list = [];

  @override
  void initState() {
    super.initState();
    _spline = SplineType.natural;
    // for (var i in widget.arr) {
    //   _list.add(
    //       _ChartData(double.parse(i.date.substring(6)), double.parse(i.nav)));
    // }
  }

  List<SplineSeries<_ChartData, num>> _getSplineTypesSeries() {
    final List<_ChartData> chartData = <_ChartData>[
      _ChartData(2011, 0.05),
      _ChartData(2011.25, 0),
      _ChartData(2011.50, 0.03),
      _ChartData(2011.75, 0),
      _ChartData(2012, 0.04),
      _ChartData(2012.25, 0.02),
      _ChartData(2012.50, -0.01),
      _ChartData(2012.75, 0.01),
      _ChartData(2013, -0.08),
      _ChartData(2013.25, -0.02),
      _ChartData(2013.50, 0.03),
      _ChartData(2013.75, 0.05),
      _ChartData(2014, 0.04),
      _ChartData(2014.25, 0.02),
      _ChartData(2014.50, 0.04),
      _ChartData(2014.75, 0),
      _ChartData(2015, 0.02),
      _ChartData(2015.25, 0.10),
      _ChartData(2015.50, 0.09),
      _ChartData(2015.75, 0.11),
      _ChartData(2016, 0.12),
    ];
    return <SplineSeries<_ChartData, num>>[
      SplineSeries<_ChartData, num>(

          // To set the spline type here.
          splineType: _spline,
          dataSource: chartData,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          width: 5)
    ];
  }

  SfCartesianChart _getTypesSplineChart() {
    return SfCartesianChart(
      palette: [blue],
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
        isVisible: false,
        majorGridLines: MajorGridLines(width: 0),
        interval: 1,
      ),
      primaryYAxis: NumericAxis(
          isVisible: false,
          labelFormat: '{value}%',
          minimum: -0.1,
          maximum: 0.2,
          interval: 0.1,
          majorTickLines: MajorTickLines(size: 0)),
      series: _getSplineTypesSeries(),
      tooltipBehavior:
          TooltipBehavior(enable: true, header: '', canShowMarker: false),
    );
  }
}
