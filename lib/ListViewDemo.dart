import 'package:flutter/material.dart';

class ListViewDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListViewDemoState();
  }
}

class ListViewDemoState extends State<ListViewDemo> {
  String datas =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ";

  Widget divider1 = Divider(
    color: Colors.red,
  );
  Widget divider2 = Divider(color: Colors.green);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ListView"),
        ),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  "  默认构造",
                  style: new TextStyle(fontSize: 16.0, color: Colors.black),
                )),
                Expanded(
                    child: Text(
                  ".builder",
                  style: new TextStyle(fontSize: 18.0, color: Colors.black),
                )),
                Expanded(
                    child: Text(
                  ".separated",
                  style: new TextStyle(fontSize: 18.0, color: Colors.black),
                )),
                Expanded(
                    child: Text(
                  "   .custom",
                  style: new TextStyle(fontSize: 18.0, color: Colors.black),
                )),
              ],
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(20),
                      children: datas
                          .split("")
                          //每一个字母都用一个Text显示,字体为原来的两倍
                          .map((c) => Text(
                                c,
                              ))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 100,
                        itemExtent: 50.0, //强制高度为50.0，可提升效率
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(title: Text("$index"));
                        }),
                  ),
                  Expanded(
                      child: ListView.separated(
                    itemCount: 100,
                    //列表项构造器
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(title: Text("$index"));
                    },
                    //分割器构造器
                    separatorBuilder: (BuildContext context, int index) {
                      return index % 2 == 0 ? divider1 : divider2;
                    },
                  )),
                  Expanded(
                      child: ListView.custom(
                    padding: EdgeInsets.all(20),
                    itemExtent: 40.0,
                    childrenDelegate: SliverChildBuilderDelegate(
                      (BuildContext context, int i) {
                        Widget result;
                        if (i < 5) {
                          result = new Text(
                            "cus${datas.split("")[i]}",
                            style: new TextStyle(
                                fontSize: 18.0, color: Colors.green),
                          );
                        } else if (i < 10) {
                          result = new Text(
                            "cus${datas.split("")[i]}",
                            style: new TextStyle(
                                fontSize: 18.0, color: Colors.red),
                          );
                        } else {
                          result = new Text(
                            "cus${datas.split("")[i]}",
                            style: new TextStyle(
                                fontSize: 18.0, color: Colors.blue),
                          );
                        }

                        return result;
                      },
                      childCount: datas.length,
                    ),
                    cacheExtent: 0.0,
                  )),
                ],
              ),
            ),
          ],
        ));
  }
}
//
//// ignore: slash_for_doc_comments
///**
// * 继承SliverChildBuilderDelegate  可以对列表的监听
// */
//class MyChildrenDelegate extends SliverChildBuilderDelegate {
//  MyChildrenDelegate(
//    Widget Function(BuildContext, int) builder, {
//    int childCount,
//    bool addAutomaticKeepAlive = true,
//    bool addRepaintBoundaries = true,
//  }) : super(builder,
//            childCount: childCount,
//            addAutomaticKeepAlives: addAutomaticKeepAlive,
//            addRepaintBoundaries: addRepaintBoundaries);
//
//  ///监听 在可见的列表中 显示的第一个位置和最后一个位置
//  @override
//  void didFinishLayout(int firstIndex, int lastIndex) {
//    print('firstIndex: $firstIndex, lastIndex: $lastIndex');
//  }
//
//  ///可不重写 重写不能为null  默认是true  添加进来的实例与之前的实例是否相同 相同返回true 反之false
//  ///listView 暂时没有看到应用场景 源码中使用在 SliverFillViewport 中
//  @override
//  bool shouldRebuild(SliverChildBuilderDelegate oldDelegate) {
//    // TODO: implement shouldRebuild
//    print("oldDelegate$oldDelegate");
//    return super.shouldRebuild(oldDelegate);
//  }
//}

void main() {
  runApp(MaterialApp(
    title: "ListView案例",
    theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
    home: ListViewDemo(),
  ));
}
