import 'package:flutter/material.dart';

import 'page/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Genial Investimentos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:
            Theme.of(context).textTheme.apply(fontFamily: "Source Sans Pro"),
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Minha carteira'),
    );
  }
}
