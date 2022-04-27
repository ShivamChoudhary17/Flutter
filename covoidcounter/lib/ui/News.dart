import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Description.dart';
import 'drawer.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late int index;
  var url =
      'https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=3d44e64c78a94ed58931cec839a62219';

  var data;
  Future getJsonData(url) async {
    var responce = await http.get(
      Uri.parse(url),
    );

    setState(() {
      var convertdata = json.decode(responce.body);
      data = convertdata['articles'];
    });
    debugPrint(responce.body);
  }

  @override
  void initState() {
    getJsonData(url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(left: 94.0),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                child: Image(
                    fit: BoxFit.contain,
                    image: AssetImage(
                      'images/covid-19'
                      '.png',
                    )),
              ),
              Text(
                "Counter",
                style: TextStyle(color: Colors.green.shade400),
              ),
            ],
          ),
        ),
      ),
      drawer: NavDrawer(),
      body: Center(
          child: (data == null)
              ? CircularProgressIndicator()
              : SafeArea(
                  child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Description(
                                              data,
                                              index,
                                            )));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Card(
                                  elevation: 10.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: ListTile(
                                    leading: Container(
                                      color: Colors.white,
                                      height: 205,
                                      width: 100,
                                      child: (data[index]['urlToImage'] == null)
                                          ? Image(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'images/newspng.png'))
                                          : Image(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  data[index]['urlToImage']),
                                            ),
                                    ),
                                    title: Text(
                                      data[index]['title'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    subtitle: Text(
                                      data[index]['source']['name'],
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ))),
    );
  }
}
