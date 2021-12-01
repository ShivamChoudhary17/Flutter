import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:quicknews/pages/newsdetails.dart';
import '../categorycard.dart';
import '../theme/changethemebutton.dart';
import '../model/categorymodel.dart';
import '../model/model.dart';
import '../model/newsmodel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  List<NewsModel> newsModelList = <NewsModel>[];
  List<NewsModel> newsModelListCarousel = <NewsModel>[];
  List<CategorieModel> categories = <CategorieModel>[];
  List<String> navBarItem = [
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    "Technology",
  ];

  bool isLoading = true;

  getNews() async {
    Map element;
    int i = 0;
    String url =
        "https://newsapi.org/v2/top-headlines?language=en&sources=google-news"
        "-in&apiKey=3d44e64c78a94ed58931cec839a62219";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      for (element in data["articles"]) {
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
    String url =
        "https://newsapi.org/v2/top-headlines?language=en&apiKey"
        "=3d44e64c78a94ed58931cec839a62219";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      for (element in data["articles"]) {
        try {
          NewsModel newsQueryModel = NewsModel();
          newsQueryModel = NewsModel.fromMap(element);
          newsModelListCarousel.add(newsQueryModel);
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
    getNews();
    getNewsOfIndia();
    categories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          "QuickNEWS",
          style: TextStyle(color: Theme.of(context).iconTheme.color),
        ),
        actions: [
          ChangeThemeButtonWidget(),
        ],
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      //Body Container
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 9.0),
          child: Column(
            children: [
              //Horizontal Scroll view
              SizedBox(
                height: 50,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      imageAssetUrl: categories[index].imageAssetUrl,
                      categoryName: categories[index].categorieName,
                    );
                  },
                ),
              ),

              //carousel_slider
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.red,
                      )
                    : CarouselSlider(
                        options: CarouselOptions(
                            height: 200,
                            autoPlay: true,
                            enlargeCenterPage: true),
                        items: newsModelListCarousel.map((instance) {
                          return Builder(builder: (BuildContext context) {
                            try {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewsWeb(
                                                newsContent:
                                                    instance.newsContent,
                                                newsUrl: instance.newsUrl,
                                                newsImg: instance.newsImg,
                                                newsHead: instance.newsHead,
                                              )));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                    Colors.black12
                                                        .withOpacity(0),
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
                              return Card();
                            }
                          });
                        }).toList(),
                      ),
              ),

              /*-- Latest News Section --*/
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 25, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Latest News",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Theme.of(context).iconTheme.color),
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
                                                  newsContent:
                                                      newsModelList[index]
                                                          .newsContent,
                                                  newsUrl: newsModelList[index]
                                                      .newsUrl,
                                                  newsImg: newsModelList[index]
                                                      .newsImg,
                                                  newsHead: newsModelList[index]
                                                      .newsHead,
                                                )));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
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
                                                    newsModelList[index]
                                                        .newsHead,
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
                      ],
                    ),
                    SizedBox(height: 50.0,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
