import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Sabitler.dart';

class GuncelDenemeWebDetay extends StatelessWidget {
  int konu_id = 1;

  GuncelDenemeWebDetay(this.konu_id);
//  const SlamiyetOncesi({Key? key}) : super(key: key);
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(gunceldenemeler[konu_id]),
        ),
        body: Container(
            child: WebView(
                onProgress: (int progress) {
                  print('WebView is loading (progress : $progress%)');
                },
                gestureNavigationEnabled: true,
                initialUrl: adreslergunceldeneme[konu_id],
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                })),
      ),
    );
  }
}
