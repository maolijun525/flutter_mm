import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mm/project/bean/HomePageArticleBean.dart';
import 'package:flutter_mm/project/model/HttpModel.dart';
import 'package:flutter_mm/project/util/UserData.dart';
import 'package:flutter_mm/project/util/Utils.dart';

class CollectArticlesListWidget extends StatefulWidget {
  CollectArticlesListWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CollectArticlesListWidgetState();
  }
}

class CollectArticlesListWidgetState extends State<CollectArticlesListWidget> {
  Articles _articles;
  List<Article> _listDatas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserData.getCookie().then((cookie) {
      if (cookie != null && cookie.length > 0) {
        print("getCookie:" + cookie);
        _queryData();
      } else {
        Utils.toLogin(this, context);
      }
    });
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
            print("index:" +
                index.toString() +
                ",_listDatas.length:" +
                _listDatas.length.toString());

            Column contentView = Column(
              key: GlobalKey(),
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

    HttpModel.queryCollectArticle(queryIndex).then((response) {
      _refresh(response, queryIndex);
    }).catchError((e) {
      print(e.toString());
    });
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
