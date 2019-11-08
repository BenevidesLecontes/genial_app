import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:genial_app/widget/bullet.dart';

class MoneyInfoCard extends StatefulWidget {
  final String label;
  final double quantity;

  MoneyInfoCard({Key key, @required this.label, @required this.quantity})
      : super(key: key);

  @override
  State createState() => _MoneyInfoCardState();
}

class _MoneyInfoCardState extends State<MoneyInfoCard> {
  bool showQuantity = false;
  final maskedQuantityWidget = <Widget>[
    Padding(
      child: Text(
        'R\$',
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
      padding: EdgeInsets.only(right: 15.0),
    ),
    Padding(
      padding: EdgeInsets.only(right: 6.0),
      child: new MyBullet(),
    ),
    Padding(
      padding: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 0.0),
      child: new MyBullet(),
    ),
    Padding(
      padding: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 0.0),
      child: new MyBullet(),
    ),
    Padding(
      padding: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 0.0),
      child: new MyBullet(),
    ),
    Padding(
      padding: EdgeInsets.only(left: 6.0),
      child: new MyBullet(),
    ),
  ];

  unsMaskedQuantityWidget(MoneyFormatterOutput fmf) {
    return <Widget>[
      Padding(
        child: Text(
          'R\$',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
        padding: EdgeInsets.only(right: 15.0),
      ),
      Text(
        fmf.nonSymbol,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    MoneyFormatterOutput fmf = FlutterMoneyFormatter(
      amount: widget.quantity,
    ).output;

    String showBtnText = showQuantity ? 'Esconder' : 'Mostrar';

    return new Container(
      decoration: BoxDecoration(
        color: Color(0xFFDDDAE0).withOpacity(0.3),
        borderRadius: BorderRadius.circular(5.0),
      ),
      height: 60.0,
      child: Stack(
          alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: [
            Positioned(
              top: -10.0,
              left: 15.0,
              child: Text(
                '${widget.label}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: showQuantity
                        ? unsMaskedQuantityWidget(fmf)
                        : maskedQuantityWidget,
                  ),
                  padding: EdgeInsets.only(left: 15.0, top: 8.0),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0, top: 8.0),
                  child: FlatButton(
                    splashColor: Colors.transparent,
                    child: new Text(
                      showBtnText,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onPressed: () {
                      setState(() => showQuantity = !showQuantity);
                    },
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}
