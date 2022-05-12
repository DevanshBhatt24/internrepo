import 'package:flutter/material.dart';

import '../styles.dart';

class CustomSlider extends StatelessWidget {
  final String title, minValue, maxValue;
  final double value;

  const CustomSlider(
      {Key key, this.title, this.minValue, this.maxValue, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 71,
      child: Column(
        children: [
          new Text(title, textAlign: TextAlign.center, style: subtitle1White),
          SizedBox(height: 21),
          Container(
            height: 12,
            child: Stack(
              children: [
                Positioned(
                  left: 40,
                  right: 40,
                  top: 3,
                  bottom: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: grey,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 40 + (1 * MediaQuery.of(context).size.width - 112) * value,
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: almostWhite,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 5,
                      child: CircleAvatar(
                        backgroundColor: almostWhite,
                        radius: 4,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  new Text(minValue, style: captionWhite),
                  new Text(" L", style: caption.copyWith(color: red))
                ],
              ),
              Row(
                children: [
                  new Text(maxValue, style: captionWhite),
                  new Text(" H", style: caption.copyWith(color: blue))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
