import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottomnavigationbar.dart';
import '../category/category.dart';
import '../categorycard.dart';
import 'home.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  List<String> navBarItem = [
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    "Technology",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          "QuickNEWS",
          style: TextStyle(color: Theme.of(context).iconTheme.color),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).iconTheme.color),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => BottomNavBar()))),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Stack(fit: StackFit.loose, children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.grey[400], borderRadius: BorderRadius.circular(24)),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  if ((searchController.text.toLowerCase()) == "") {
                    print("Blank search");
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Category(
                                Query: searchController.text.toLowerCase())));
                  }
                },
                child: Container(
                  child: Icon(CupertinoIcons.search,
                      color: Theme.of(context).iconTheme.color),
                  margin: EdgeInsets.fromLTRB(5, 0, 16, 0),
                ),
              ),
              Expanded(
                  child: TextField(
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Category(Query: value)));
                },
                decoration: const InputDecoration(
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.black),
                    hintText: "Search...",
                    border: InputBorder.none),
              )),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          height: 280,
          padding: const EdgeInsets.only(top: 100, left: 130),
          child: DottedBorder(
            strokeWidth: 2.5,
            borderType: BorderType.RRect,
            radius: Radius.circular(18),
            padding: EdgeInsets.all(9),
            dashPattern: [9, 3, 5, 4],
            color: Colors.lightBlueAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (var i in navBarItem)
                  Text(i,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
