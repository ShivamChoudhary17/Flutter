import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quicknews/pages/webpage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:html/parser.dart';

class NewsWeb extends StatefulWidget {
  final String newsHead, newsImg, newsContent, newsUrl;
  NewsWeb(
      {required this.newsHead,
      required this.newsImg,
      required this.newsContent,
      required this.newsUrl});

  @override
  _NewsWebState createState() => _NewsWebState();
}

class _NewsWebState extends State<NewsWeb> {
  late String finalurl;
  final Completer<WebViewController> controller =
      Completer<WebViewController>();


  @override
  Widget build(BuildContext context) {
    final document = parse(widget.newsContent);
    final String parsedString = parse(document.body!.text).documentElement!.text;

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          title: Text(
            "QuickNEWS",
            style: TextStyle(color: Theme.of(context).iconTheme.color),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
              onPressed: () => Navigator.of(context).pop()),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: Scaffold(
            body: Padding(
          padding:  EdgeInsets.all(14.0),
          child: ListView(
            children: <Widget>[
              Align(
                  alignment: Alignment(-1.05, 1),),
              SizedBox(height: 18.0,),
              Hero(tag: widget.newsImg, child: Image.network(widget.newsImg)),
              Padding(padding: EdgeInsets.only(top: 8.0)),
              SizedBox(height: 18.0,),
              Text(
                widget.newsHead,
                style: GoogleFonts.zillaSlab(
                  color: Theme.of(context).accentColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 18.0,),
              Text(
                parsedString,
                style: GoogleFonts.zillaSlab(
                  color: Theme.of(context).accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 40.0,),
              FlatButton.icon(
                icon: Icon(Icons.open_in_new, color: Theme.of(context).iconTheme.color),
                label: Text("Read Full Story", style: TextStyle(color: Theme
                        .of(context).iconTheme.color),),
                onPressed: () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => WebPage(newsUrl: widget.newsUrl,)
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}

/*
WebView(
initialUrl: finalurl,
javascriptMode: JavascriptMode.unrestricted,
onWebViewCreated: (WebViewController webViewController){
setState(() {
controller.complete(webViewController);
});
},
),*/
