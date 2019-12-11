import 'package:flutter/material.dart';

class Toast {
  final BuildContext context;
  final String text;
  final Duration duration;

  Toast(this.context, this.text, {this.duration = const Duration(seconds: 1)});

  void show() {
    OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
      return new Positioned(
          top: MediaQuery.of(context).size.height * 0.7,
          child: new Material(
            child: new Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: new Center(
                child: new Card(
                  child: new Padding(
                    padding: EdgeInsets.all(8),
                    child: new Text(text),
                  ),
                  color: Colors.grey,
                ),
              ),
            ),
          ));
    });
    Overlay.of(context).insert(overlayEntry);
    new Future.delayed(duration).then((value) {
      overlayEntry.remove();
    });
  }
}
