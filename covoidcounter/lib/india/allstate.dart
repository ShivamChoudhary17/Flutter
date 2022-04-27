import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../model/statwmodel.dart';
import '../ui/drawer.dart';
import 'chackvac.dart';

class AllState extends StatefulWidget {
  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<AllState> {
  List<StateModel> stateModelList = <StateModel>[];
  bool isLoading = true;

  getData() async {
    Map element;
    int i = 0;
    String url = "https://www.mohfw.gov.in/data/datanew.json";
    Response response = await get(Uri.parse(url));
    var data = jsonDecode(response.body);
    setState(() {
      for (element in data) {
        try {
          StateModel stateModel = StateModel();
          stateModel = StateModel.fromMap(element);
          stateModelList.add(stateModel);
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

  var vacUrl = "https://cdn-api.co-vin.in/api/v1/reports/getLiveVaccination";
  var vaciData;
  var url2 = "https://corona.lmao.ninja/v3/covid-19/countries";
  var countiData;
  var url =
      "https://www.mygov.in/sites/default/files/covid/vaccine/vaccine_counts_today.json";
  var data;
  Future getJsonData() async {
    http.Response responce = await http.get(Uri.parse(url));
    http.Response vacResponce = await http.get(Uri.parse(vacUrl));
    http.Response contResponce = await http.get(Uri.parse(url2));

    setState(() {
      var countryData = json.decode(responce.body);
      var vacData = json.decode(vacResponce.body);
      var conData = json.decode(contResponce.body);
      data = countryData;
      vaciData = vacData;

      setState(() {
        for (var i in conData) {
          if (i['country'] == 'India') {
            countiData = i;
          }
        }
      });
    });
  }

  @override
  void initState() {
    getData();
    getJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.green),
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Padding(
              padding: const EdgeInsets.only(left: 91.0),
              child: Row(
                children: [
                  const SizedBox(
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
          drawer: const NavDrawer(),
          body: data == null
              ? Center(
                  child: FadingText(
                    'Stay safe during the pandemic...',
                    style: const TextStyle(
                      letterSpacing: 3.0,
                    ),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          initialPage: 0,
                          height: 400,
                          autoPlay: true,
                          enlargeCenterPage: true),
                      items: [
                        SingleChildScrollView(
                            child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Card(
                                shadowColor: Colors.green,
                                elevation: 18,
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            countiData['country'],
                                            style: const TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 20),
                                          ),
                                          Container(
                                            height: 35,
                                            width: 65,
                                            child: Image(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  countiData['countryInfo']
                                                      ['flag']),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Cases',
                                            style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Text(
                                            'Deaths',
                                            style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            countiData['cases'].toString(),
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            '${countiData['deaths']}',
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'CasesPerOneMillion',
                                            style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Text(
                                            'Recovered',
                                            style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            countiData['casesPerOneMillion']
                                                .toString(),
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            countiData['recovered'].toString(),
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'DeathsPerOneMillion',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            countiData['deathsPerOneMillion']
                                                .toString(),
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Tests',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            countiData['tests'].toString(),
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        )),
                        SingleChildScrollView(
                            child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Card(
                                shadowColor: Colors.green,
                                elevation: 18,
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Day: ',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            '${data['day']}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 26),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'India Dose 1',
                                            style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Text(
                                            'India Dose 2',
                                            style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${data['india_dose1']}',
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            '${data['india_dose2']}',
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'India Total Dose 1',
                                            style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Text(
                                            'India Total Dose 1',
                                            style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${data['india_dose2']}',
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            '${data['india_dose2']}',
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'India Live Dose ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${vaciData['count']}',
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 26),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CheckVac()));
                                        },
                                        child: const Text(
                                          'Check Nearest Center',
                                          style: TextStyle(
                                              color: Colors.lightBlueAccent,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                          height: 200, autoPlay: true, enlargeCenterPage: true),
                      items: stateModelList.map((instance) {
                        return Builder(builder: (BuildContext context) {
                          try {
                            return InkWell(
                              onTap: () {},
                              child: Card(
                                elevation: 16,
                                shadowColor: Colors.green.shade800,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(14.0, 5, 14, 5),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            instance.stateName.length > 24
                                                ? '${instance.stateName.substring(0, 24)}...'
                                                : instance.stateName,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Active',
                                            style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Text(
                                            'Positive',
                                            style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            instance.active,
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            instance.positive,
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'New Active',
                                            style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Text(
                                            'New Positive',
                                            style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            instance.newActive,
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            instance.newPositive,
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Deaths',
                                            style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Text(
                                            'Cured',
                                            style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            instance.death,
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            instance.cured,
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } catch (e) {
                            return const Card();
                          }
                        });
                      }).toList(),
                    ),
                  ],
                )),
    );
  }
}
