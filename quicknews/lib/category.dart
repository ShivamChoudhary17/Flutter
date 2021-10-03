import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:quicknews/webview.dart';

import 'model/newsmodel.dart';

class Category extends StatefulWidget {
  String Query="";
  Category({required this.Query});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<NewsModel> newsModelList = <NewsModel>[];


  bool isLoading = true;

  String url="";
  getNews(String query) async {
    Map element;
    if(query == "Top News") {
      url = "https://inshorts-news.vercel.app/all";
    }else{
      url =
      "https://inshorts-news.vercel.app/$query";
    }
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      for (element in data["data"]) {
        try {
        NewsModel newsModel = NewsModel();
        newsModel = NewsModel.fromMap(element);
        newsModelList.add(newsModel);
        setState(() {
          isLoading = false;
        });
        } catch (e) {
          print(e);
        }
        ;
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews(widget.Query);
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
      body:
      SingleChildScrollView(
        child: Column(
          children: [

            Container(
              margin: EdgeInsets.fromLTRB(15, 25, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 12,),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                    widget.Query,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 39),
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? CircularProgressIndicator()
                :
            Column(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newsModelList.length,
                  itemBuilder: (context, index) {
                    try{
                    return
                      Container(
                      margin:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsWeb(newsModelList[index].newsUrl)));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 1.0,
                          child: Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    newsModelList[index].newsImg,
                                    fit: BoxFit.fitHeight,
                                    height: 230,
                                    width: double.infinity,
                                  )),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black12.withOpacity(0),
                                            Colors.black
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        )),
                                    padding: EdgeInsets.fromLTRB(15, 15, 10, 8),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          newsModelList[index].newsHead,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          newsModelList[index].newsDes.length >
                                              50
                                              ? "${newsModelList[index].newsDes.substring(0, 50)}..."
                                              : newsModelList[index].newsDes,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ],
                                    )),
                              ),

                            ],
                          ),
                        ),
                      ),

                    );

                    } catch(e){print(e); return Container();}
                  },
                ),
                Container(
                    padding:  EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                    child: Icon(CupertinoIcons.check_mark_circled_solid,
                      color: Colors.lightGreen,
                    size: 55,)
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                  child: const Text("You'r All Caught Up", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600

                  ),),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                  child: const Text("For Now", style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500
                  ),
                  ),
                ),
              ],
            ),



          ],
        ),

      ),
    );
  }
}

