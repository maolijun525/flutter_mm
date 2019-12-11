import 'package:flutter/material.dart';
import 'package:flutter_mm/project/bean/HomePageArticleBean.dart';
import 'package:flutter_mm/project/model/HttpModel.dart';
import 'package:flutter_mm/project/util/Toast.dart';
import 'package:flutter_mm/project/util/UserData.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  final int articleId; //文章id，没有传-1
  final String url;
  final String title;
  final bool withZoom;
  final bool withLocalStorage;
  final bool hidden;
  final Widget initChild;

  WebViewPage(
      {Key key,
      this.articleId,
      this.url,
      this.title,
      this.withZoom,
      this.withLocalStorage,
      this.hidden,
      this.initChild})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WebViewPageState();
  }
}

class WebViewPageState extends State<WebViewPage> {
  bool collected = false;
  int id = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.articleId;
    print("widget.url:" + widget.url);
    List<int> collects = UserData.user.collectIds;
    print(" user.collectIds:" + collects.toString() + ", id:" + id.toString());
    if (collects != null && collects.length > 0) {
      collects.forEach((art) {
        if (widget.articleId == art) {
          collected = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: Text(widget.title),
        actions: id == -1
            ? null
            : <Widget>[
                IconButton(
                  color: collected ? Colors.orange : Colors.white30,
                  icon: const Icon(Icons.star),
                  onPressed: () {
                    print("click star");
                    _clickCollect();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                )
              ],
      ),
      withZoom: widget.withZoom,
      withLocalStorage: widget.withLocalStorage,
      hidden: widget.hidden,
      initialChild: widget.initChild,
    );
  }

  void _clickCollect() {
    collected ? _doUnCollect() : _doCollect();
  }

  void _doCollect() {
    HttpModel.doCollectArticle(id).then((response) {
      print(response);
      if (response?.errorCode == 0) {
        UserData.user?.collectIds?.add(id);
        setState(() {
          collected = true;
        });
      } else {
        Toast(context, response?.errorMsg).show();
      }
    }).catchError((e) {
      Toast(context, e?.errorMsg).show();
    });
  }

  void _doUnCollect() {
    HttpModel.doUnCollectArticle(id).then((response) {
      print(response);
      if (response?.errorCode == 0) {
        UserData.user?.collectIds?.remove(id);
        setState(() {
          collected = false;
        });
      } else {
        Toast(context, response?.errorMsg).show();
      }
    }).catchError((e) {
      Toast(context, e?.errorMsg).show();
    });
  }
}
