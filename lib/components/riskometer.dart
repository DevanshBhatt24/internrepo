import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:technical_ind/screens/commodity/commodityindicator.dart';
import 'package:technical_ind/screens/etf/business/models/etf_explore_model.dart';
import 'package:technical_ind/styles.dart';

import 'sampleview.dart';

class DistanceTrackerExample extends SampleView {
  final String meter;
  final Riskometer riskometer;
  DistanceTrackerExample({this.meter, this.riskometer});
  @override
  _DistanceTrackerExampleState createState() => _DistanceTrackerExampleState(
      meter: this.meter, riskometer: this.riskometer);
}

class _DistanceTrackerExampleState extends SampleViewState {
  _DistanceTrackerExampleState({this.meter, this.riskometer});
  final String meter;
  final Riskometer riskometer;
  List<Ref> refList = [
    Ref(blue, "Very Low"),
    Ref(blue.withOpacity(0.6), "Moderately Low"),
    Ref(yellow, "Moderate"),
    Ref(red.withOpacity(0.6), "Moderately High"),
    Ref(red, "Very High"),
  ];
  Ref selected;
  double angleValue;
  _loadMeter() {
    for (var i in refList) {
      if (i.text.trim().toLowerCase() ==
          meter.split('-')[1].trim().toLowerCase()) {
        selected = i;
        break;
      }
    }
    if (selected.text == "Very Low") {
      angleValue = 20;
    } else if (selected.text == "Moderately Low") {
      angleValue = 40;
    } else if (selected.text == "Moderate") {
      angleValue = 60;
    } else if (selected.text == "Moderately High") {
      angleValue = 80;
    } else if (selected.text == "Very High") {
      angleValue = 100;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadMeter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      animationDuration: 2400,
      enableLoadingAnimation: true,
      axes: <RadialAxis>[
        RadialAxis(
          showLabels: false,
          showTicks: false,
          startAngle: 180,
          endAngle: 0,
          radiusFactor: 0.8,
          minimum: 0,
          maximum: 100,
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              angle: 90,
              positionFactor: 0.2,
              widget: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(selected.text,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: selected.color,
                          fontSize: 18)),
                ],
              ),
            )
          ],
          pointers: <GaugePointer>[
            RangePointer(
              animationDuration: 5000,
              value: angleValue,
              width: 6,
              pointerOffset: 0,
              cornerStyle: CornerStyle.bothCurve,
              color: selected.color,
              // Color.fromRGBO(255, 77, 0, 1),
            ),
            NeedlePointer(
              value: angleValue,
              needleLength: 0.6,
              lengthUnit: GaugeSizeUnit.factor,
              needleStartWidth: 4,
              needleEndWidth: 4,
              animationType: AnimationType.easeOutBack,
              enableAnimation: true,
              animationDuration: 1200,
              knobStyle: KnobStyle(
                  knobRadius: 0.09,
                  sizeUnit: GaugeSizeUnit.factor,
                  borderColor: Colors.black,
                  color: Colors.white,
                  borderWidth: 0.05),
              needleColor: Colors.white,
            )
          ],
          axisLineStyle:
              AxisLineStyle(cornerStyle: CornerStyle.startCurve, thickness: 6),
        )
      ],
    );
  }

  // SfRadialGauge _getDistanceTrackerExample() {
  //   return SfRadialGauge(
  //     enableLoadingAnimation: true,
  //     axes: <RadialAxis>[
  //       RadialAxis(
  //         showLabels: false,
  //         showTicks: false,
  //         startAngle: 180,
  //         endAngle: 0,
  //         radiusFactor: 0.8,
  //         minimum: 0,
  //         maximum: 100,
  //         annotations: <GaugeAnnotation>[
  //           GaugeAnnotation(
  //             angle: 90,
  //             positionFactor: 0.2,
  //             widget: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 SizedBox(height: 15),
  //                 Text('ss',
  //                     style: TextStyle(
  //                         fontWeight: FontWeight.w600,
  //                         color: selected.color,
  //                         fontSize: 18)),
  //               ],
  //             ),
  //           )
  //         ],
  //         pointers: <GaugePointer>[
  //           RangePointer(
  //             value: 70,
  //             width: 6,
  //             pointerOffset: 0,
  //             cornerStyle: CornerStyle.bothCurve,
  //             color: Color.fromRGBO(255, 77, 0, 1),
  //           ),
  //           NeedlePointer(
  //             value: 70,
  //             needleLength: 0.6,
  //             lengthUnit: GaugeSizeUnit.factor,
  //             needleStartWidth: 4,
  //             needleEndWidth: 4,
  //             animationType: AnimationType.easeOutBack,
  //             enableAnimation: true,
  //             animationDuration: 1200,
  //             knobStyle: KnobStyle(
  //                 knobRadius: 0.09,
  //                 sizeUnit: GaugeSizeUnit.factor,
  //                 borderColor: Colors.black,
  //                 color: Colors.white,
  //                 borderWidth: 0.05),
  //             needleColor: Colors.white,
  //           )
  //         ],
  //         axisLineStyle:
  //             AxisLineStyle(cornerStyle: CornerStyle.startCurve, thickness: 6),
  //       )
  //     ],
  //   );
  // }
}
