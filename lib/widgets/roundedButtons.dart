import 'package:flutter/material.dart';

import '../styles.dart';

class RoundedButton extends StatefulWidget {
  final String value, groupValue;

  Function onpress;

  RoundedButton({Key key, this.value, this.groupValue, this.onpress})
      : super(key: key);

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onpress,
      child: Container(
        margin: EdgeInsets.all(3),
        height: 32,
        width: 56,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: widget.groupValue == widget.value
                    ? almostWhite
                    : Colors.white38,
                width: 1)),
        child: Center(
          child: Text(
            widget.value,
            textAlign: TextAlign.center,
            style: caption.copyWith(
              color: widget.groupValue == widget.value ? almostWhite : white38,
            ),
          ),
        ),
      ),
    );
  }
}
