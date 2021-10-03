import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWeb extends StatefulWidget {

  String url;
  NewsWeb(this.url);

  @override
  _NewsWebState createState() => _NewsWebState();
}

class _NewsWebState extends State<NewsWeb> {

  late String finalurl;
  final Completer<WebViewController> controller = Completer<WebViewController>();
  
  @override
  void initState() {
    // TODO: implement initState
    if(widget.toString().contains("http://")) {
      finalurl = widget.url.toString().replaceAll("http://", "https://");
    }
    else {
      finalurl = widget.url;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "QuickNEWS",
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: WebView(
        initialUrl: finalurl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController){
          setState(() {
            controller.complete(webViewController);
          });
        },
      ),
    );
  }
}
