import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RefreshListViewDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RefreshListViewDemoState();
  }
}

class RefreshListViewDemoState extends State<RefreshListViewDemo> {
  static const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];
  bool showRefreshLoad = false; //控制何时展示下拉刷新loading

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("ListView下拉刷新，上拉加载更多"),
        ),
        body: RefreshIndicator(
          onRefresh: _toRefresh,
          child: ListView.separated(
            itemBuilder: (context, index) {
              if (_words[index] == loadingTag) {
                if (_words.length - 1 < 100) {
                  //获取数据
                  _retrieveData();
                  //加载时显示loading
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(strokeWidth: 2.0)),
                  );
                } else {
//已经加载了100条数据，不再获取数据。
                  return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "没有更多了",
                        style: TextStyle(color: Colors.grey),
                      ));
                }
              }
              //显示单词列表项
              return ListTile(title: Text(_words[index]));
            },
            separatorBuilder: (context, index) => Divider(height: .0),
            itemCount: _words.length,
          ),
        ));
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      _words.insertAll(
          _words.length - 1,
          //每次生成20个单词
          generateWordPairs().take(15).map((e) => e.asPascalCase).toList());
      setState(() {
        //重新构建列表
      });
    });
  }

  Future _toRefresh() async {
    // 延迟3秒后添加新数据， 模拟网络加载
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _words.clear();
        _words.addAll(
            //每次生成20个单词
            generateWordPairs().take(15).map((e) => e.asPascalCase).toList());
        _words.add(loadingTag); //最后加上结束标记
      });
    });
  }
}

void main() {
  runApp(new MaterialApp(
    title: "ListView下拉刷新，上拉加载更多",
    theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
    home: RefreshListViewDemo(),
  ));
}
