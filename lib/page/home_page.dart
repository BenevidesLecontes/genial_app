import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:genial_app/models/investiment.dart';
import 'package:genial_app/models/pie_data.dart';
import 'package:genial_app/models/wallet.dart';
import 'package:genial_app/styles.dart';
import 'package:genial_app/utils/flutter_ui_utils.dart' as ui;
import 'package:genial_app/widget/indicator.dart';
import 'package:genial_app/widget/money_info_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<charts.Series<Investment, String>> _seriesPieData;
  List wallets;

  _generateData() {
    _seriesPieData.add(
      charts.Series(
        domainFn: (Investment investment, _) => investment.investment,
        measureFn: (Investment investment, _) => investment.value,
        colorFn: (Investment investment, _) =>
            charts.ColorUtil.fromDartColor(investment.color),
        id: 'Carteira de Investimentos',
        data: pieData,
        labelAccessorFn: (Investment row, _) => '${row.value}',
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _seriesPieData = List<charts.Series<Investment, String>>();
    _generateData();
    wallets = getWallets();
  }

  List getWallets() {
    return allWallets.toList();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Wallet wallet) {
      MoneyFormatterOutput fmf = FlutterMoneyFormatter(
        amount: wallet.balance,
        settings: MoneyFormatterSettings(
          symbol: 'R\$',
        ),
      ).output;
      return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        title: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                child: Text(
                  wallet.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.0,
                  ),
                ),
                padding: EdgeInsets.only(right: 15.0),
              ),
            ),
            Expanded(
              flex: 2,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Qtde',
                    style: TextStyle(
                      color: Color(0xff444444),
                      fontWeight: FontWeight.w300,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    "${wallet.quantity} ativos",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Saldo bruto',
                    style: TextStyle(
                      color: Color(0xff444444),
                      fontWeight: FontWeight.w300,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    fmf.symbolOnLeft,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        trailing: Icon(Icons.add, color: Color(0xff364dcd), size: 20.0),
      );
    }

    Card makeCard(Wallet wallet) => Card(
          elevation: 0.0,
          margin: new EdgeInsets.symmetric(
            vertical: 0.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: wallet.bgColor,
              border: Border(
                  left: BorderSide(color: wallet.borderColor, width: 6.0)),
            ),
            child: makeListTile(wallet),
          ),
        );

    List<Card> makeCardsList() => wallets.map((w) => makeCard(w)).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ui.appBarHeight(context)),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset(0, 2.0),
              blurRadius: 4.0,
            )
          ]),
          child: AppBar(
            backgroundColor: AppColor.appBlue,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () => {},
            ),
            title: Text(
              widget.title,
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.00),
                child: CircleAvatar(
                  backgroundColor: AppColor.lightGrey,
                  child: Image.asset(
                    'assets/images/foto.png',
                    width: 38.00,
                    height: 38.00,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  left: 20.00, right: 20.00, top: 25.00, bottom: 25.00),
              child: new Column(
                children: <Widget>[
                  MoneyInfoCard(
                    label: 'Disponível para investir',
                    quantity: 3000.00,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 18.0,
                    ),
                    child: MoneyInfoCard(
                      label: 'A liquidar',
                      quantity: 60000.00,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        top: 32.0,
                        bottom: 15.0,
                        left: 15.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'carteira de investimentos'.toUpperCase(),
                          style: TextStyle(
                            color: Color(0xFF5a5a5a),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                  Card(
                    child: Container(
                      height: 425,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: AspectRatio(
                              child: Stack(
                                children: <Widget>[
                                  charts.PieChart(
                                    _seriesPieData,
                                    animate: true,
                                    animationDuration: Duration(
                                      milliseconds: 500,
                                    ),
                                    defaultRenderer: charts.ArcRendererConfig(
                                      arcWidth: 25,
                                      strokeWidthPx: 0,
                                    ),
                                  ),
                                  Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "R\$ 5.620.080,85",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "22 ativos",
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                              aspectRatio: 1.3,
                            ),
                          ),
                          Wrap(
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runSpacing: 24.0,
                            spacing: 24.0,
                            children: const <Widget>[
                              Padding(
                                child: Indicator(
                                  color: Color(0xff179016),
                                  text: 'Renda Fixa',
                                  textColor: Colors.black,
                                  isSquare: false,
                                  subText: '10% | 5 ativos',
                                ),
                                padding:
                                    EdgeInsets.only(right: 24.0, left: 10.0),
                              ),
                              Padding(
                                child: Indicator(
                                  color: Color(0xff00bdc4),
                                  text: 'Fundos',
                                  textColor: Colors.black,
                                  isSquare: false,
                                  subText: '10% | 5 ativos',
                                ),
                                padding: EdgeInsets.only(right: 24.0),
                              ),
                              Padding(
                                child: Indicator(
                                  color: Color(0xff28388f),
                                  text: 'Previdência',
                                  textColor: Colors.black,
                                  isSquare: false,
                                  subText: '10% | 5 ativos',
                                ),
                                padding: EdgeInsets.only(right: 10.0),
                              ),
                              Padding(
                                child: Indicator(
                                  color: Color(0xffff9800),
                                  text: 'Ações/Futuro',
                                  textColor: Colors.black,
                                  isSquare: false,
                                  subText: '10% | 5 ativos',
                                ),
                                padding: EdgeInsets.only(right: 24.0),
                              ),
                              Padding(
                                child: Indicator(
                                  color: Color(0xffad1457),
                                  text: 'Tesouro',
                                  textColor: Colors.black,
                                  isSquare: false,
                                  subText: '10% | 5 ativos',
                                ),
                                padding: EdgeInsets.only(right: 24.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        top: 32.0,
                        bottom: 15.0,
                        left: 15.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'posição consolidada'.toUpperCase(),
                          style: TextStyle(
                            color: Color(0xFF5a5a5a),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                  ...makeCardsList()
                ],
              ))
        ],
      ),
    );
  }
}
