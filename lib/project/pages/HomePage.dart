import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mm/project/bean/HomePageArticleBean.dart';
import 'package:flutter_mm/project/bean/HomePageBannerBean.dart';
import 'package:flutter_mm/project/model/HttpModel.dart';
import 'package:flutter_mm/project/util/Utils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  // This widget is the root of your application.
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  int curBannerIndex = 0;
  List<BannerData> _homeBannerData;
  Articles _articles;
  List<Article> _listDatas;

  @override
  void initState() {
    super.initState();
    _queryHomeBanner();
    _queryHomeArticle();
  }

  Widget _swiper() {
    return Container(
      height: 200,
      color: Color(233),
      child: Swiper(
        scrollDirection: Axis.horizontal,
        loop: true,
        autoplay: true,
        index: curBannerIndex,
        onIndexChanged: (index) {
          curBannerIndex = index;
        },
        itemBuilder: (BuildContext context, int index) {
          return _getSwiperItem(context, index);
        },
        itemCount: _homeBannerData?.length ?? 0,
        pagination: new SwiperPagination(),
      ),
    );
  }

  Widget _getSwiperItem(BuildContext context, int index) {
    if (_homeBannerData != null) {
      var banner = _homeBannerData[index];
      if (banner == null) {
        return null;
      } else {
        return GestureDetector(
          onTap: () {
            //点击跳转
            Utils.openToWebView(context, banner.id, banner.url, banner.title);
          },
          child: Image.network(banner.imagePath, fit: BoxFit.fill),
        );
      }
    } else {
      return null;
    }
  }

  Widget _list() {
    return RefreshIndicator(
        onRefresh: _toRefresh,
        child: ListView.builder(
            itemCount: _listDatas?.length ?? 0,
            itemExtent: 70.0, //强制高度为50.0，可提升效率
            itemBuilder: (BuildContext context, int index) {
              Article article = _listDatas[index];
              if (index == _listDatas.length - 1) {
                if (_articles.curPage < _articles.pageCount) {
                  //获取数据
                  _queryHomeArticle();
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
              return Container(
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
                      title: Text(index.toString() + "：" + article.title)),
                ),
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (_listDatas == null || _listDatas.length <= 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
          body: Column(
        children: <Widget>[
          _swiper(),
          Expanded(
            child: _list(),
          )
        ],
      ));
    }
  }

  void _queryHomeBanner() {
    HttpModel.queryHomeBanner().then((response) {
      setState(() {
        _homeBannerData = response.data;
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future _toRefresh() async {
    _articles = null;
    _queryHomeArticle();
    print("_toRefresh");
  }

  void _queryHomeArticle() {
    int queryIndex = 0;
    if (_articles != null) {
      queryIndex = _articles.curPage;
    }
    HttpModel.queryHomeArticle(queryIndex).then((response) {
      print("response" + mounted.toString());
      setState(() {
        print("setState");
        _articles = response.data;
        if (queryIndex == 0) {
          _listDatas = _articles.datas;
          print("_listDatas" + _listDatas.toString());
        } else {
          _listDatas.addAll(_articles.datas);
        }
      });
    }).catchError((e) {
      print(e.toString);
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
