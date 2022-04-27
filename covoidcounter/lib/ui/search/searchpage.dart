import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../CountryInfo.dart';
import 'countryCard.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var data;
  searchData(String name) async {
    var url = "https://corona.lmao.ninja/v3/covid-19/countries/$name";
    http.Response response = await http.get(Uri.parse(url));

    setState(() {
      var da = json.decode(response.body);
      data = da;
      if (data != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CountryCard(data)));
      }
    });
    debugPrint(response.body);
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.greenAccent),
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.grey.shade200,
          title: Padding(
            padding: const EdgeInsets.only(left: 91.0),
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
        body: SizedBox(
          child: Column(
              children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onSubmitted: (value) {
                        setState(() {
                          searchData(searchController.text);
                        });
                      },
                      textInputAction: TextInputAction.search,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        fillColor: Colors.redAccent,
                        hintText: "Search Your Country",
                        hintStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      var text = searchController.text.substring(0, 1).toUpperCase() +
                          searchController.text.substring(1,searchController
                      .text
                          .length).toLowerCase();
                      setState(() {
                        searchData(searchController.text);
                      });
                    },
                      child: Icon(Icons.forward))
                ],
              ),
            ),

          ]),
        ));
  }
}
