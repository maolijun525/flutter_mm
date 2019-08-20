import 'package:flutter/material.dart';

class RowAndColumnDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("线性布局")),
      body: new Column(
        children: <Widget>[
          new Text("下面是Row"),
          new Row(
            //子布局方向
            textDirection: TextDirection.rtl,
            //子布局整体对齐方式（靠坐、靠右、两端对齐等）
            mainAxisAlignment: MainAxisAlignment.center,
            //父布局水平撑满还是自适应，max是撑满，min是自定义。
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            //垂直方向上的对齐方式
            verticalDirection: VerticalDirection.down,
            textBaseline: TextBaseline.ideographic,
            children: <Widget>[
              new Text("one", style: new TextStyle(color: Colors.red)),
              new Text("two", style: new TextStyle(color: Colors.green)),
              new Text("three", style: new TextStyle(color: Colors.blue)),
            ],
          ),
          new Text("下面是Column"),
          ConstrainedBox(
              constraints: BoxConstraints(minWidth: double.infinity),
              child: new Column(
//            //子布局整体对齐方式（靠坐、靠右、两端对齐等）
//            mainAxisAlignment: MainAxisAlignment.start,
                //父布局水平撑满还是自适应，max是撑满，min是自定义。
                mainAxisSize: MainAxisSize.max,
                //子布局左右对齐（仅对Column有效）
                crossAxisAlignment: CrossAxisAlignment.center,
                //垂直方向上的对齐方式（仅对Column有效）
                verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  new Text("four", style: new TextStyle(color: Colors.red)),
                  new Text("five", style: new TextStyle(color: Colors.green)),
                  new Text("six", style: new TextStyle(color: Colors.blue)),
                ],
              )),
          Container(
            color: Colors.green,
            constraints: BoxConstraints(minWidth: double.infinity),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max, //有效，外层Colum高度为整个屏幕
                children: <Widget>[
                  Container(
                    color: Colors.red,
                    child: Column(
                      mainAxisSize: MainAxisSize.max, //无效，内层Colum高度为实际高度
                      children: <Widget>[
                        Text("hello world "),
                        Text("I am Jack "),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          Expanded(
            child: Container(
              color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, //垂直方向居中对齐
                children: <Widget>[
                  Text("hello world "),
                  Text("I am Jack "),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(
    title: "线性布局案例",
    theme: new ThemeData(primaryColor: Colors.deepOrangeAccent),
    home: new RowAndColumnDemo(),
  ));
}
