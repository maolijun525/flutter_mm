import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mm/project/bean/PubSubArticleListBean.dart';
import 'package:flutter_mm/project/model/HttpModel.dart';
import 'package:flutter_mm/project/util/Utils.dart';

class SubscriptionListWidget extends StatefulWidget {
  int id; //公众号id

  SubscriptionListWidget({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SubscriptionListWidgetState();
  }
}

class SubscriptionListWidgetState extends State<SubscriptionListWidget>
    with AutomaticKeepAliveClientMixin<SubscriptionListWidget> {
  SubArticleList _subArticleList;
  List<SubArticle> _listDatas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _querySubscriptionData();
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
            SubArticle article = _listDatas[index];
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
                )
              ],
            );
            if (index == _listDatas.length - 1) {
              if (_subArticleList.curPage < _subArticleList.pageCount) {
                //获取数据
                _querySubscriptionData();
                //加载时显示loading
                contentView.children.add(Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: CircularProgressIndicator(strokeWidth: 2.0)),
                ));
              } else {
                //超过最大加载数，不再获取数据。
                contentView.children.add(Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "没有更多了",
                      style: TextStyle(color: Colors.grey),
                    )));
              }
            }
            return contentView;
          }),
    );
  }

  void _querySubscriptionData() {
    int queryIndex = 0;
    if (_subArticleList != null) {
      queryIndex = _subArticleList.curPage + 1;
    }
    HttpModel.queryPubSubArticle(widget.id.toString(), queryIndex)
        .then((response) {
      setState(() {
        _subArticleList = response?.data;
        if (queryIndex == 0) {
          _listDatas = _subArticleList?.datas ?? [];
        } else {
          _listDatas.addAll(_subArticleList?.datas);
        }
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future _toRefresh() async {
    _subArticleList = null;
    _querySubscriptionData();
    print("_toRefresh");
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
