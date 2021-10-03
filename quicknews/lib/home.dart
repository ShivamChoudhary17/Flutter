import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:quicknews/webview.dart';

import 'category.dart';
import 'model/newsmodel.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  List<NewsModel> newsModelList = <NewsModel>[];
  List<NewsModel> newsModelListCarousel = <NewsModel>[];

  List<String> navBarItem = [
    "all",
    "national",
    "world",
    "politics",
    "technology",
    "startup",
    "business",
    "automobile"
  ];

  bool isLoading = true;

  getNews() async {
    Map element;
    int i = 0;
    String url = "https://inshorts-news.vercel.app/politics";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      for (element in data["data"]) {
        try {
          //i++;
          NewsModel newsModel = NewsModel();
          newsModel = NewsModel.fromMap(element);
          newsModelList.add(newsModel);
          setState(() {
            isLoading = false;
          });
          if (i == 5) break;
        } catch (e) {
          print(e);
        }
        ;
      }
    });
  }

  getNewsOfIndia() async {
    Map element;
    int i = 0;
    String url = "https://inshorts-news.vercel.app/national";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      for (element in data["data"]) {
        try {
          //i++;
          NewsModel newsQueryModel = NewsModel();
          newsQueryModel = NewsModel.fromMap(element);
          newsModelListCarousel.add(newsQueryModel);
          setState(() {
            isLoading = false;
          });
          //if (i == 5) break;
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
    getNews();
    getNewsOfIndia();
  }

  @override
  Widget build(BuildContext context) {
    final _random = Random();
    var news = navBarItem[_random.nextInt(navBarItem.length)];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "QuickNEWS",
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      //Body Container
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Search Bar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(24)),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if ((searchController.text) == "") {
                        print("Blank search");
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Category(Query: searchController.text)));
                      }
                    },
                    child: Container(
                      child: Icon(CupertinoIcons.search, color: Colors.blue),
                      margin: EdgeInsets.fromLTRB(5, 0, 8, 0),
                    ),
                  ),
                  Expanded(
                      child: TextField(
                    /*textAlign: TextAlign.center,*/
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Category(Query: value)));
                    },
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.black),
                        hintText: "Search ' $news ' news",
                        border: InputBorder.none),
                  ))
                ],
              ),
            ),

            //Horizontal Scroll view
            SizedBox(
              height: 50,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: navBarItem.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Category(Query: navBarItem[index])));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: Text(
                        navBarItem[index],
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                    ),
                  );
                },
              ),
            ),

            //carousel_slider
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: isLoading
                  ? CircularProgressIndicator()
                  : CarouselSlider(
                      options: CarouselOptions(
                          height: 200, autoPlay: true, enlargeCenterPage: true),
                      items: newsModelListCarousel.map((instance) {
                        return Builder(builder: (BuildContext context) {
                          try {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NewsWeb(instance.newsUrl)));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          instance.newsImg,
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                        )),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.black12.withOpacity(0),
                                                  Colors.black
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              )),
                                          child: Text(instance.newsHead,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white))),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } catch (e) {
                            print(e);
                            return Card();
                          }
                        });
                      }).toList(),
                    ),
            ),

            //Image News List
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 25, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "Latest News",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: newsModelList.length,
                        itemBuilder: (context, index) {
                          try {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewsWeb(
                                              newsModelList[index].newsUrl)));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  elevation: 1.0,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            newsModelList[index].newsImg,
                                            fit: BoxFit.fill,
                                            height: 230,
                                            width: double.infinity,
                                          )),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.black12
                                                        .withOpacity(0),
                                                    Colors.black
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                )),
                                            padding: EdgeInsets.fromLTRB(
                                                15, 15, 10, 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  newsModelList[index].newsHead,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  newsModelList[index]
                                                              .newsDes
                                                              .length >
                                                          50
                                                      ? "${newsModelList[index].newsDes.substring(0, 50)}..."
                                                      : newsModelList[index]
                                                          .newsDes,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } catch (e) {
                            print(e);
                            return Container();
                          }
                        },
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Category(Query: "all")));
                                },
                                child: Text("SHOW MORE")),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
