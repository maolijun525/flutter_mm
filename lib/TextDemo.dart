import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("文本控件"),
      ),
      body: new Column(
        children: <Widget>[
          new Text(
            "红色+黑色删除线+20号",
            style: new TextStyle(
                color: const Color(0xffff0000),
                decoration: TextDecoration.lineThrough,
                decorationColor: const Color(0xff000000),
                fontSize: 20.0),
          ),
          new Text(
            "橙色+下划线+21号",
            style: new TextStyle(
                color: const Color(0xffff9900),
                decoration: TextDecoration.underline,
                decorationColor: const Color(0xffff9900),
                fontSize: 21.0),
          ),
          new Text(
            "虚线上划线+22号+倾斜",
            style: new TextStyle(
                decoration: TextDecoration.overline,
                decorationStyle: TextDecorationStyle.dashed,
                fontSize: 22.0,
                fontStyle: FontStyle.italic),
          ),
          new Text(
            "serif字体+23号",
            style: new TextStyle(
              fontFamily: "serif",
              fontSize: 23.0,
            ),
          ),
          new Text(
            "monospace字体+24号+加粗",
            style: new TextStyle(
              fontFamily: 'monospace',
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          new Text(
            "天蓝色+25号+两行跨度",
            style:
                new TextStyle(color: Colors.cyan, fontSize: 25.0, height: 2.0),
          ),
          new Text(
            "26号+10个字符间隔",
            style: new TextStyle(fontSize: 26.0, letterSpacing: 10.0),
          ),
//          new Text(
//            " 对齐方式：向右对齐  TextAlign.right  ",
//            style: new TextStyle(color: Colors.blue[400], fontSize: 24.0),
//            textAlign: TextAlign.right,
//          ),
//          new Text(
//            "对齐方式：向左对齐  TextAlign.left ",
//            style: new TextStyle(color: Colors.blue[200], fontSize: 24.0),
//            textAlign: TextAlign.left,
//          ),
//          new Text(
//            "对齐方式：居中对齐 TextAlign.center ",
//            style: new TextStyle(color: Colors.blue[400], fontSize: 24.0),
//            textAlign: TextAlign.center,
//          ),
//          new Text(
//            "对齐方式： 两端对齐  TextAlign. justify ",
//            style: new TextStyle(color: Colors.blue[200], fontSize: 24.0),
//            textAlign: TextAlign.justify,
//          ),
//          new Text(
//            "文本方向：从右到左  TextDirection.rtl ",
//            style: new TextStyle(color: Colors.blue, fontSize: 20.0),
//            textDirection: TextDirection.rtl,
//          ),
//          new Text(
//            "文本方向：从左到右  TextDirection.ltr ",
//            style: new TextStyle(color: Colors.blue, fontSize: 20.0),
//            textDirection: TextDirection.ltr,
//          ),
          new Text("",
              style: new TextStyle(color: Colors.pink, fontSize: 20.0),
              semanticsLabel: 'Double dollars',
              locale: Localizations.localeOf(context)
//            maxLines: 2, //如果softWrap和maxLines同时赋值，以maxLines为最高优先级。
              ),
          new Text(
            "单行显示，不换行。单行显示，不换行。 单行显示，不换行。",
            style: new TextStyle(color: Colors.pink, fontSize: 20.0),
            overflow: TextOverflow.ellipsis, //超出用...代替
            softWrap: false, //不换行
//            maxLines: 2, //如果softWrap和maxLines同时赋值，以maxLines为最高优先级。
          ),
          new Text(
            "字体10，倍率为2",
            style: new TextStyle(color: Colors.yellow[700], fontSize: 10.0),
            textScaleFactor: 2.0,
          ),
          new Text.rich(
            new TextSpan(
                text: "one",
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.green,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.purple,
                  decorationStyle: TextDecorationStyle.wavy,
                ),
                children: [
                  new TextSpan(
                      text: "TWO",
                      style: new TextStyle(
                        fontSize: 30.0,
                        color: Colors.green,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.purple,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          var alert = new AlertDialog(
                            title: new Text("Title"),
                            content: new Text("TWO"),
                          );
                          showDialog(context: context, child: alert);
                        }),
                  new TextSpan(
                      text: "THREE",
                      style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.black12,
                        decoration: TextDecoration.overline,
                        decorationColor: Colors.redAccent,
                        decorationStyle: TextDecorationStyle.dashed,
                      ),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          var alert = new AlertDialog(
                            title: new Text("Title"),
                            content: new Text("THREE"),
                          );
                          showDialog(context: context, child: alert);
                        }),
                  new TextSpan(
                      text: "FOUR",
                      style: new TextStyle(
                        fontSize: 40.0,
                        color: Colors.green,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.yellowAccent,
                        decorationStyle: TextDecorationStyle.dotted,
                      ),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          var alert = new AlertDialog(
                            title: new Text("Title"),
                            content: new Text("FOUR"),
                          );
                          showDialog(context: context, child: alert);
                        })
                ],
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                    var alert = new AlertDialog(
                      title: new Text("Title"),
                      content: new Text("one"),
                    );
                    showDialog(context: context, child: alert);
                  }),
          )
        ],
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(
    title: "文本案例",
    theme: new ThemeData(primaryColor: Colors.deepOrangeAccent),
    home: new TextDemo(),
  ));
}
