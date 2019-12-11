import 'package:flutter/material.dart';
import 'package:flutter_mm/project/bean/HotKeyBean.dart';
import 'package:flutter_mm/project/bean/PubSubscriptionBean.dart';
import 'package:flutter_mm/project/model/HttpModel.dart';

typedef Function ButtonCallback(String key, String author);

class SearchSuggestWidget extends StatefulWidget {
  final ButtonCallback _onTextClick;

  SearchSuggestWidget(this._onTextClick);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchSuggestWidgetState();
  }
}

class SearchSuggestWidgetState extends State<SearchSuggestWidget>
    with AutomaticKeepAliveClientMixin<SearchSuggestWidget> {
  List<HotKey> datas = [];

  List<Subscription> _authorData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _queryHotKey();
    _getAuthorData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: Text(
            "大家都在搜：",
            textAlign: TextAlign.left,
          ),
        ),
        Wrap(
          children: datas.map((item) {
//            return Container(
//              child: Text(item.name),
//            );
            return Container(
                height: 30,
                margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                child: FlatButton(
                  color: Colors.grey[200],
                  highlightColor: Colors.grey,
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  child: Text(item.name),
                  textColor: Colors.black45,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  onPressed: () {
                    widget._onTextClick(item.name, "");
                  },
                ));
          }).toList(),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: Text(
            "按作者搜：",
            textAlign: TextAlign.left,
          ),
        ),
        Wrap(
          children: _authorData.map((item) {
//            return Container(
//              child: Text(item.name),
//            );
            return Container(
                height: 30,
                margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                child: FlatButton(
                  color: Colors.grey[200],
                  highlightColor: Colors.grey,
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  child: Text(item.name),
                  textColor: Colors.black45,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  onPressed: () {
                    widget._onTextClick("", item.name);
                  },
                ));
          }).toList(),
        ),
      ],
    );
  }

  void _queryHotKey() {
    HttpModel.queryHotKey().then((response) {
      setState(() {
        if (response != null &&
            response.data != null &&
            response.data.length > 0) {
          datas = response.data;
        }
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  void _getAuthorData() {
    HttpModel.queryPubSubscription().then((response) {
      setState(() {
        _authorData = response?.data ?? [];
        print("_authorData" + _authorData.toString());
      });
    }).catchError((e) {
      print(e.toString);
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
