import 'package:flutter/material.dart';
import 'package:flutter_mm/project/widget/ArticlesListWidget.dart';
import 'package:flutter_mm/project/widget/SearchSuggestWidget.dart';

///继承官方搜索控件
class SearchPage extends SearchDelegate<String> {
  String _key;
  String _author;

  @override
  List<Widget> buildActions(BuildContext context) {
    // 这个方法返回一个控件列表，显示为搜索框右边的图标按钮

    return [
      MaterialButton(
        child: Text("清除"),
        onPressed: () {
          query = "";
          showSuggestions(context); //显示默认内容
        },
      ),
    ];
    ;
  }

  @override
  Widget buildLeading(BuildContext context) {
    // 这个方法返回一个控件，显示为搜索框左侧的按钮
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = "";
          showSuggestions(context);
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // 这个方法返回一个控件，显示为搜索内容区域的搜索结果内容
    return ArticlesListWidget(
      queryValue: _key,
      author: _author,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // 这个方法返回一个控件，显示为搜索内容区域的建议内容
    return SearchSuggestWidget((key, author) {
      if (key != null && key.length > 0) {
        query = key;
        this._key = key;
        this._author = "";
      } else if (author != null && author.length > 0) {
        query = author;
        this._key = "";
        this._author = author;
      }
      showResults(context);
    });
//  return ArticlesListWidget(queryValue: "android",author: "鸿洋",);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    // 这个方法返回一个主题，也就是可以自定义搜索界面的主题样式
    return super.appBarTheme(context);
  }
}

//
//
//class SearchPageState extends State<SearchPage> {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//        body: Column(
//      children: <Widget>[
//        _search(),
//        Expanded(
//          child: _content(),
//        )
//      ],
//    ));
//  }
//
//  ///搜索控件
//  Widget _search() {}
//
//  ///列表页与推荐页切换
//  Widget _content() {}
//}
