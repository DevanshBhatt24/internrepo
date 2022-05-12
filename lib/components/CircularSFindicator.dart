import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CircularSFindicator extends StatelessWidget {
  final Widget center;
  final double radius, value, thickness;
  final Color color, backgroundColor;
  const CircularSFindicator({
    Key key,
    this.center,
    this.radius = 60,
    this.value = 50,
    this.thickness = 6,
    this.color,
    this.backgroundColor = const Color(0xff2c2c2e),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      child: Stack(
        children: [
          Positioned.fill(
              child: Center(
            child: center,
          )),
          SfRadialGauge(
            axes: [
              RadialAxis(
                  radiusFactor: 1,
                  showTicks: false,
                  startAngle: -90,
                  endAngle: 270,
                  showFirstLabel: false,
                  minimum: 0,
                  maximum: 100,
                  showLabels: false,
                  pointers: [
                    RangePointer(
                      value: value,
                      width: thickness,
                      color: color,
                      enableAnimation: true,
                      cornerStyle: CornerStyle.bothCurve,
                      animationType: AnimationType.easeInCirc,
                    )
                  ],
                  axisLineStyle: AxisLineStyle(
                    color: backgroundColor,
                    thickness: thickness,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
