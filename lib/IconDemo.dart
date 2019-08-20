import 'package:flutter/material.dart';
import 'package:flutter_mm/MyIcons.dart';

class TextDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String icons = "";
    icons += "\uE914";
    icons += " \uE000";
    icons += " \uE90D";

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("图标控件"),
      ),
      body: new Column(
        children: <Widget>[
          Text(
            icons,
            style: TextStyle(
                fontFamily: "MaterialIcons",
                fontSize: 24.0,
                color: Colors.green),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.accessible,
                color: Colors.red,
                size: 30.0,
              ),
              Icon(
                Icons.error,
                color: Colors.yellow,
                size: 30.0,
              ),
              Icon(
                Icons.fingerprint,
                color: Colors.blue,
                size: 30.0,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                MyIcons.strawberry,
                color: Colors.red[400],
              ),
              Icon(
                MyIcons.iceLolly,
                color: Colors.green,
              ),
              Icon(
                MyIcons.donut,
                color: Colors.pink[300],
              ),
            ],
          )
        ],
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(
    title: "图标案例",
    theme: new ThemeData(primaryColor: Colors.deepOrangeAccent),
    home: new TextDemo(),
  ));
}
