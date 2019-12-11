import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mm/project/bean/HomePageArticleBean.dart';
import 'package:flutter_mm/project/bean/StudyTreeBean.dart';
import 'package:flutter_mm/project/model/HttpModel.dart';
import 'package:flutter_mm/project/pages/StudyArticlesListPage.dart';
import 'package:flutter_mm/project/util/Utils.dart';

class StudyTreeListWidget extends StatefulWidget {
  StudyTreeListWidget({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StudyTreeListWidgetState();
  }
}

class StudyTreeListWidgetState extends State<StudyTreeListWidget>
    with AutomaticKeepAliveClientMixin<StudyTreeListWidget> {
  StudyTreeBean _articles;
  List<StudyGroup> _listDatas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _queryData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _listDatas?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          StudyGroup group = _listDatas[index];
          Column contentView = Column(children: <Widget>[
            Container(
                alignment: Alignment.center,
                color: Colors.white,
                margin:
                    EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 0),
                child: GestureDetector(
                    onTap: () {
                      //点击跳转
                    },
                    child: ExpansionTile(
                      title: Text(group.name),
                      backgroundColor:
                          Theme.of(context).accentColor.withOpacity(0.025),
                      children: group.children.map((child) {
                        return GestureDetector(
                            onTap: () {
                              //点击跳转
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return StudyArticlesListPage(
                                    cid: child.id, name: child.name);
                              }));
                            },
                            child: ListTile(
                                leading: IconButton(
                                    icon: Icon(Icons.book), onPressed: null),
                                title: Text(
                                  child.name,
                                  style: TextStyle(fontSize: 14),
                                )));
                      }).toList(),
                    )))
          ]);

          Widget itemMore = _itemMore(index);
          if (itemMore != null) {
            contentView.children.add(itemMore);
          }
          return contentView;
        });
  }

  void _queryData() {
    HttpModel.queryStudyTree().then((response) {
      setState(() {
        _articles = response;
        _listDatas = response?.data;
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  Widget _itemMore(int index) {
    if (index == _listDatas.length - 1) {
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
