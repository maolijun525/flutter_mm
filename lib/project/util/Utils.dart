import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mm/project/pages/LoginPage.dart';
import 'package:flutter_mm/project/pages/WebViewPage.dart';

class Utils {
  static void openToWebView(
      BuildContext context, int articleId, String url, String title) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return WebViewPage(
        articleId: articleId,
        url: url,
        title: title,
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initChild: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }));
  }

  static void toLogin(
    State state,
    BuildContext context,
  ) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginPage();
    })).then((value) {
      state?.setState(() {});
    });
  }
}
