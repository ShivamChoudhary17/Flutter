import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  final String newsUrl;
  WebPage({required this.newsUrl});

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late String finalurl;
  final Completer<WebViewController> controller =
      Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.toString().contains("http://")) {
      finalurl = widget.newsUrl.toString().replaceAll("http://", "https://");
    } else {
      finalurl = widget.newsUrl;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          "QuickNEWS",
          style: TextStyle(color: Theme.of(context).iconTheme.color),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme
                .color),
            onPressed: () => Navigator.of(context).pop()),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Scaffold(
        body: WebView(
          gestureNavigationEnabled: true,
          zoomEnabled: true,
          initialUrl: finalurl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            setState(() {
              controller.complete(webViewController);
            });
          },
        ),
      ),
    );
  }
}
