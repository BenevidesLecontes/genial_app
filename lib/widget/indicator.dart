import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;
  final bool isColumn;
  final String subText;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 8,
    this.textColor = const Color(0xff505050),
    this.isColumn = true,
    this.subText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
          color: color,
        ),
      ),
      const SizedBox(
        width: 4,
      ),
      Text(
        text,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.normal, color: textColor),
      ),
    ];

    if (subText != null) {
      children.add(Text(
        subText,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          color: Color(0xff444444),
          fontSize: 14,
        ),
      ));
    }

    if (!isColumn) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
