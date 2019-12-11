import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mm/project/bean/HomePageArticleBean.dart';
import 'package:flutter_mm/project/model/HttpModel.dart';
import 'package:flutter_mm/project/util/Utils.dart';

class ArticlesListWidget extends StatefulWidget {
  final String queryValue; //查找关键字
  final String author; //查找作者

  ArticlesListWidget({Key key, this.queryValue, this.author}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ArticlesListWidgetState();
  }
}

class ArticlesListWidgetState extends State<ArticlesListWidget> {
  Articles _articles;
  List<Article> _listDatas;
  String valueKey; //查找关键字
  String authorKey; //查找作者

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    valueKey = widget.queryValue;
    authorKey = widget.author;
    print("queryValue:" + widget.queryValue + ",author" + widget.author);
    _queryData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
      onRefresh: _toRefresh,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _listDatas?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            Article article = _listDatas[index];
            Column contentView = Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  color: Colors.white,
//                padding: EdgeInsets.only(left: 10),
                  margin:
                      EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 0),
                  child: GestureDetector(
                    onTap: () {
                      //点击跳转
                      Utils.openToWebView(
                          context, article.id, article.link, article.title);
                    },
                    child: ListTile(
                        title: Text(
                      index.toString() + "：" + article.title,
                      style: TextStyle(fontSize: 14),
                    )),
                  ),
                ),
              ],
            );

            Widget itemMore = _itemMore(index);
            if (itemMore != null) {
              contentView.children.add(itemMore);
            }
            return contentView;
          }),
    );
  }

  void _queryData() {
    int queryIndex = 0;
    if (_articles != null) {
      queryIndex = _articles.curPage;
    }
    if (valueKey != null && valueKey.length > 0) {
      //按关键字查询
      HttpModel.queryKeyArticle(valueKey, queryIndex).then((response) {
        _refresh(response, queryIndex);
      }).catchError((e) {
        print(e.toString());
      });
    } else if (authorKey != null && authorKey.length > 0) {
      //按作者查询
      HttpModel.queryAuthorArticle(authorKey, queryIndex).then((response) {
        _refresh(response, queryIndex);
      }).catchError((e) {
        print(e.toString());
      });
    } else {
      //没有关键字,查询最新文章列表
      HttpModel.queryHomeArticle(queryIndex).then((response) {
        _refresh(response, queryIndex);
      }).catchError((e) {
        print(e.toString());
      });
    }
  }

  Future _toRefresh() async {
    _articles = null;
    _queryData();
    print("_toRefresh");
  }

  void _refresh(HomePageArticleBean response, int queryIndex) {
    setState(() {
      _articles = response?.data;
      if (queryIndex == 0) {
        _listDatas = _articles?.datas ?? [];
      } else {
        _listDatas.addAll(_articles?.datas);
      }
    });
  }

  Widget _itemMore(int index) {
    if (index == _listDatas.length - 1) {
      if (_articles.curPage < _articles.pageCount) {
        //获取数据
        _queryData();
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
        //超过最大加载数，不再获取数据。
        return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16.0),
            child: Text(
              "没有更多了",
              style: TextStyle(color: Colors.grey),
            ));
      }
    }
  }
}
