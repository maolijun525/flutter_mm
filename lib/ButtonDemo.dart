import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("按钮控件"),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add_a_photo),
//            child: new Text('FloatingActionButton'),
        tooltip: 'click FloatingActionButton',
        onPressed: () {},
      ),
      body: new Column(
        children: <Widget>[
          new MaterialButton(
//            color: Color(0xffff9900),
            child: new Text('MaterialButton'),
            onPressed: () {},
          ),
          new RaisedButton(
            child: new Text('RaisedButton'),
            onPressed: () {},
          ),
          new FlatButton(
            child: new Text('FlatButton'),
            onPressed: () {},
          ),
          new IconButton(
            icon: new Icon(Icons.wifi),
            tooltip: 'click IconButton',
//            child: new Text('IconButton'),
            onPressed: () {},
          ),
          new FloatingActionButton(
            child: new Icon(Icons.add_a_photo),
//            child: new Text('FloatingActionButton'),
            tooltip: 'click FloatingActionButton',
            onPressed: () {},
          ),
          new ButtonBar(
            children: <Widget>[
              new BackButton(),
              new CloseButton(),
              new Text('ButtonBar组件'),
              new RaisedButton(
                child: new Text('Button'),
                onPressed: () {},
              ),
            ],
          ),
          RaisedButton.icon(
            icon: Icon(Icons.send),
            label: Text("发送"),
            onPressed: () {},
          ),
          OutlineButton.icon(
            icon: Icon(Icons.add),
            label: Text("添加"),
            onPressed: () {},
          ),
          FlatButton.icon(
            icon: Icon(Icons.info),
            label: Text("详情"),
            onPressed: () {},
          ),
          OutlineButton(
            child: Text("OutlineButton"),
            borderSide: new BorderSide(color: Colors.pink),
            onPressed: () {},
          ),
          FlatButton(
            color: Colors.blue,
            highlightColor: Colors.blue[700],
            colorBrightness: Brightness.dark,
            splashColor: Colors.grey,
            child: Text("Submit"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: () {},
          )
//          new Text(
//            "橙色+下划线+21号",
//            style: new TextStyle(
//                color: const Color(0xffff9900),
//                decoration: TextDecoration.underline,
//                decorationColor: const Color(0xffff9900),
//                fontSize: 21.0),
//          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(
    title: "Button案例",
    theme: new ThemeData(primaryColor: Colors.deepOrangeAccent),
    home: new TextDemo(),
  ));
}
