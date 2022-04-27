import 'dart:convert';
import 'package:covoidcounter/ui/search/searchpage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'CountryInfo.dart';

class AllCountry extends StatefulWidget {
  @override
  _AllCountryState createState() => _AllCountryState();
}

class _AllCountryState extends State<AllCountry> {
  TextEditingController editingController = TextEditingController();
  late int index;
  var url = "https://corona.lmao.ninja/v3/covid-19/countries";
  var data, allCountryData;
  Future getJsonData(url) async {
    var responce = await http.get(Uri.parse(url));

    setState(() {
      var countryData = json.decode(responce.body);
      data = countryData;
    });
    //debugPrint(responce.body);
  }

  @override
  void initState() {
    getJsonData(url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.greenAccent,
            ),
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
            centerTitle: true,
            actions: [
              // Navigate to the Search Screen
              IconButton(
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SearchPage())),
                  icon: Icon(
                    Icons.search,
                    color: Colors.green.shade700,
                  ))
            ],
            elevation: 0,
            backgroundColor: Colors.transparent,
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
          body: (data == null && allCountryData == null)
              ? Center(
                  child: FadingText(
                    'Stay safe during the pandemic...',
                    style: TextStyle(
                      letterSpacing: 3.0,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(10, 16, 10, 10),
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CountryInfo(data, index)));
                        },
                        child: Card(
                          child: ListTile(
                            leading: Container(
                              height: 50,
                              width: 70,
                              color: Colors.deepPurpleAccent,
                              child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    data[index]['countryInfo']['flag']),
                              ),
                            ),
                            title: Text(
                              data[index]['country'],
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black),
                            ),
                            subtitle: Text(
                              "Total Cases",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600),
                            ),
                            trailing: Text(
                              "${data[index]['cases']}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )),
    );
  }
}
