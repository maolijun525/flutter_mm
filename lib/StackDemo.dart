import 'package:flutter/material.dart';

class StackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("层叠布局"),
        ),
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            alignment: Alignment.center,
            //指定未定位或部分定位widget的对齐方式
            textDirection: TextDirection.rtl,
            fit: StackFit.loose,
            overflow: Overflow.clip,
            children: <Widget>[
              Container(
                child:
                    Text("Hello world", style: TextStyle(color: Colors.white)),
                color: Colors.red,
              ),
              Positioned(
                left: 18.0,
                child: Text("left"),
              ),
              Positioned(
                top: 18.0,
                child: Text("top"),
              ),
              Positioned(
                right: 18.0,
                child: Text("right"),
              ),
              Positioned(
                bottom: 18.0,
                child: Text("bottom"),
              )
            ],
          ),
        ));
  }
}

void main() {
  runApp(new MaterialApp(
    title: "层叠布局案例",
    theme: new ThemeData(primaryColor: Colors.deepOrangeAccent),
    home: new StackDemo(),
  ));
}
