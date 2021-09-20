import 'package:flutter/material.dart';
import 'package:vendas_app/src/view/menu_view.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  static String tag = 'home-page';

  @override
  AppState createState() {
    return new AppState();
  }
}

class AppState extends State<App> {
  Widget pagAtual;
  MenuView home = new MenuView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color(0xff317183)),
      home: home,
    );
  }
}
