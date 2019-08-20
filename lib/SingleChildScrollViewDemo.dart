import 'package:flutter/material.dart';

class SingleChildScrollViewDemo extends StatefulWidget {
  @override
  SingleChildScrollViewDemoState createState() {
    return SingleChildScrollViewDemoState();
  }
}

class SingleChildScrollViewDemoState extends State<SingleChildScrollViewDemo> {
  ScrollController mController = new ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  @override
  void initState() {
    //监听滚动事件，打印滚动位置
    mController.addListener(() {
      print(mController.offset); //打印滚动位置
      if (mController.offset < 200 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (mController.offset >= 200 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String str =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scaffold(
        // 显示进度条
        appBar: new AppBar(title: new Text("滚动控件SingleChildScrollView")),
        floatingActionButton: !showToTopBtn
            ? null
            : FloatingActionButton(
                child: Icon(Icons.arrow_upward),
                onPressed: () {
                  //返回到顶部时执行动画
                  mController.animateTo(.0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                }),
        body: Column(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Row(
                  //动态创建一个List<Widget>
                  children: str
                      .split("")
                      //每一个字母都用一个Text显示,字体为原来的两倍
                      .map((c) => Text(
                            c,
                            textScaleFactor: 2.0,
                          ))
                      .toList(),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(16.0),
                controller: mController,
                child: Center(
                  child: Column(
                    //动态创建一个List<Widget>
                    children: str
                        .split("")
                        //每一个字母都用一个Text显示,字体为原来的两倍
                        .map((c) => Text(
                              c,
                              textScaleFactor: 2.0,
                            ))
                        .toList(),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

void main() {
  runApp(new MaterialApp(
    title: "SingleChildScrollView案例",
    theme: new ThemeData(primaryColor: Colors.deepOrangeAccent),
    home: new SingleChildScrollViewDemo(),
  ));
}
