import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../pages/medicine/medicines_page.dart';
import '../pages/precaution_page/precaution_page.dart';
import '../pages/symptoms/symptoms_page.dart';
import 'AllCountry.dart';
import 'CountryInfo.dart';
import 'drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int index;
  var url = "https://corona.lmao.ninja/v3/covid-19/countries";
  var url1 = "https://corona.lmao.ninja/v3/covid-19/all";
  var url2 = "https://corona.lmao.ninja/v2/all?yesterday=";
  var data, allCountryData;
  Future getJsonData(url, url1, url3) async {
    var responce = await http.get(Uri.parse(url));
    var responceAll = await http.get(Uri.parse(url1));
    var responceallYestr = await http.get(Uri.parse(url2));

    setState(() {
      var countryData = json.decode(responce.body);
      var allData = json.decode(responceAll.body);
      var allDataYestr = json.decode(responceallYestr.body);
      data = countryData;
      allCountryData = allData;
    });
    /*debugPrint(responce.body);
    debugPrint(responceAll.body);
    debugPrint(responceallYestr.body);*/
  }

  @override
  void initState() {
    getJsonData(url, url1, url2);
    super.initState();
  }

//${allCountryData['cases']}
  @override
  Widget build(BuildContext context) {
    return (data == null && allCountryData == null)
        ? Center(
            child: FadingText(
              'Stay safe during the pandemic...',
              style: TextStyle(
                letterSpacing: 3.0,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.green),
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Padding(
                padding: const EdgeInsets.only(left: 95.0),
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
      drawerEnableOpenDragGesture: true,
            body: SingleChildScrollView(
              child: IntrinsicHeight(
                child: SafeArea(
                  child: Column(children: [
                    Container(
                      height: 230,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              color: Colors.greenAccent.shade100,
                              shadowColor: Colors.greenAccent.shade700,
                              elevation: 18,
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      child: Image(
                                          fit: BoxFit.contain,
                                          image: AssetImage(
                                            'images/covid-19'
                                            '.png',
                                          )),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      'Confirmed Cases',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${allCountryData['cases']}',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.redAccent.shade100,
                              shadowColor: Colors.red.shade700,
                              elevation: 18,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(22.0, 0, 18, 22),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        child: Image(
                                            fit: BoxFit.contain,
                                            image: AssetImage(
                                              'images/covid-19'
                                              '.png',
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      'Deaths ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${allCountryData['deaths']}',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        height: 280.0,
                        child: Container(
                          decoration: new BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(20.0),
                              topRight: const Radius.circular(20.0),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "Most affected country",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0, vertical: 4),
                                    child: FlatButton(
                                      onPressed: () {
                                        debugPrint("See all Botton Call");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AllCountry()));
                                      },
                                      child: Text(
                                        "See all",
                                        style: TextStyle(
                                          color: Colors.green.shade400,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 8.0),
                                      child: Card(
                                        elevation: 16,
                                        shadowColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        color: Color(0xffF6F7F9),
                                        child: Container(
                                          height: 90,
                                          width: 160,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CountryInfo(
                                                              data, index)));
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                ListTile(
                                                  leading: Image(
                                                    height: 30.0,
                                                    width: 30.0,
                                                    image: /*(data == null)
                                                        ? CircularProgressIndicator()
                                                        : */NetworkImage(data[
                                                                    index]
                                                                ['countryInfo']
                                                            ['flag']),
                                                  ),
                                                  trailing: (data == null)
                                                      ? CircularProgressIndicator()
                                                      : Text(
                                                          data[index]
                                                              ['country'],
                                                          style: TextStyle(
                                                              fontSize: 17.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                    Icons
                                                        .confirmation_num_rounded,
                                                    color: Colors.black87,
                                                  ),
                                                  trailing: (data == null)
                                                      ? CircularProgressIndicator()
                                                      : Text(
                                                          "${data[index]['cases']}",
                                                          style: TextStyle(
                                                              fontSize: 17.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                ),
                                                ListTile(
                                                  leading: (data == null)
                                                      ? CircularProgressIndicator()
                                                      : Icon(
                                                          Icons
                                                              .airline_seat_individual_suite,
                                                          color: Colors.black87,
                                                        ),
                                                  trailing: (data == null)
                                                      ? CircularProgressIndicator()
                                                      : Text(
                                                          "${data[index]['deaths']}",
                                                          style: TextStyle(
                                                              fontSize: 17.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0, top: 22.0),
                          child: Text(
                            "Always Remember to",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: Container(
                      height: 250.0,
                      child:
                          ListView(scrollDirection: Axis.horizontal, children: <
                              Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: Row(children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PrecautionsScreen(color: Colors.red,)));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Stack(
                                  children: <Widget>[
                                    Card(
                                      elevation: 20,
                                      shadowColor: Colors.green,
                                      color: Colors.greenAccent.shade200,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Container(
                                        height: 185,
                                        width: 170,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                color:
                                                    Colors.greenAccent.shade200,
                                                height: 65,
                                                width: 65,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8.0))),
                                                  child: Image(
                                                    fit: BoxFit.contain,
                                                    image: AssetImage(
                                                        "images/precaution.png"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16.0,
                                                      horizontal: 12.0),
                                              child: Text(
                                                "Precautions",
                                                style: TextStyle(
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 1.5,
                                                  color:
                                                      Colors.redAccent.shade200,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8.0),
                              child: Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SymptomsScreen()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Stack(
                                        children: <Widget>[
                                          Card(
                                            elevation: 20,
                                            shadowColor: Colors.green,
                                            color: Colors.greenAccent.shade200,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Container(
                                              height: 185,
                                              width: 170,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      color: Colors
                                                          .greenAccent.shade200,
                                                      height: 65,
                                                      width: 65,
                                                      child: Card(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        8.0))),
                                                        child: Image(
                                                          fit: BoxFit.contain,
                                                          image: AssetImage(
                                                              "images/pic3.png"),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 16.0,
                                                        horizontal: 12.0),
                                                    child: Text(
                                                      "Symptoms",
                                                      style: TextStyle(
                                                        fontSize: 22.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        letterSpacing: 1.5,
                                                        color: Colors
                                                            .redAccent.shade200,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MedicinesPage()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8.0),
                                      child: Stack(
                                        children: <Widget>[
                                          Card(
                                            elevation: 20,
                                            shadowColor: Colors.green,
                                            color: Colors.greenAccent.shade200,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Container(
                                              height: 185,
                                              width: 170,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      color: Colors
                                                          .greenAccent.shade200,
                                                      height: 65,
                                                      width: 65,
                                                      child: Card(
                                                        //      color: Colors.white,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            8.0))),
                                                        child: Image(
                                                          fit: BoxFit.contain,
                                                          image: AssetImage(
                                                              "images/medicines.png"),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 16.0,
                                                        horizontal: 12.0),
                                                    child: Text(
                                                      "Medicines",
                                                      style: TextStyle(
                                                        fontSize: 22.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        letterSpacing: 1.5,
                                                        color: Colors
                                                            .redAccent.shade200,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ]),
                    )),
                  ]),
                ),
              ),
            ),
          );
  }
}
