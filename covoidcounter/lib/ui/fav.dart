import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_indicators/progress_indicators.dart';

import 'drawer.dart';

class SpecialPage extends StatefulWidget {
  const SpecialPage({Key? key}) : super(key: key);


  @override
  _SpecialPageState createState() => _SpecialPageState();
}

class _SpecialPageState extends State<SpecialPage> {
  bool isLoading = true;

  var url = "https://data.covid19india.org/v4/min/data.min.json";
  var data;
  Future getJsonData(url) async {
    var responce = await http.get(Uri.parse(url));

    setState(() {
      var countryData = json.decode(responce.body);
      data = countryData;
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
    return (data == null)
        ? Center(
      child: CircularProgressIndicator()
    )
        :
    Scaffold(
      appBar: AppBar(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.lightGreenAccent),
        elevation: 0,
        backgroundColor: Colors.white,
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
              Text("Counter",
                style: TextStyle(
                    color: Colors.green.shade400
                ),),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Darbhanga',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 29),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(

                        'Confirmed',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                      Text(

                        'Deceased',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data['BR']['districts']['Darbhanga']['total']['confirmed'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                          '${data['BR']['districts']['Darbhanga']['total']['deceased'
                          ]}',
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(

                        'Recovered',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                      Text(

                        'Tested',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data['BR']['districts']['Darbhanga']['total']['recovered'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        '${data['BR']['districts']['Darbhanga']['total']['tested'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(

                        '1st vaccination',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                      Text(

                        '2nd vaccinated',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data['BR']['districts']['Darbhanga']['total']['vaccinated1'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        '${data['BR']['districts']['Darbhanga']['total']['vaccina'
                            'ted2'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(

                        'Confirmed',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                      Text(

                        'Deceased',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data['BR']['districts']['Darbhanga']['total']['confirmed'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        '${data['BR']['districts']['Darbhanga']['total']['deceased'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40,),
              Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New Delhi',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 29),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(

                        'Confirmed',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                      Text(

                        'Deceased',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data['DL']['districts']['Delhi']['total']['conf'
                            'irmed'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        '${data['DL']['districts']['Delhi']['total']['deceased'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(

                        'Recovered',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                      Text(

                        'Tested',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data['DL']['districts']['Delhi']['total']['reco'
                            'vered'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        '${data['DL']['districts']['Delhi']['total']['tes'
                            'ted'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(

                        '1st vaccination',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                      Text(

                        '2nd vaccinated',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data['DL']['districts']['Delhi']['total']['vacc'
                            'inated1'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        '${data['DL']['districts']['Delhi']['total']['vacc'
                            'ina'
                            'ted2'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(

                        'Confirmed',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                      Text(

                        'Deceased',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data['DL']['districts']['Delhi']['total']['conf'
                            'irmed'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        '${data['DL']['districts']['Delhi']['total']['dece'
                            'ased'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40,),
              Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ranchi',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 29),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(

                        'Confirmed',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                      Text(

                        'Deceased',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data['JH']['districts']['Ranchi']['total']['conf'
                            'irmed'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        '${data['JH']['districts']['Ranchi']['total']['deceased'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(

                        'Recovered',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                      Text(

                        'Tested',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data['JH']['districts']['Ranchi']['total']['reco'
                            'vered'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        '${data['JH']['districts']['Ranchi']['total']['tes'
                            'ted'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(

                        '1st vaccination',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                      Text(

                        '2nd vaccinated',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data['JH']['districts']['Ranchi']['total']['vacc'
                            'inated1'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        '${data['JH']['districts']['Ranchi']['total']['vacc'
                            'ina'
                            'ted2'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(

                        'Confirmed',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                      Text(

                        'Deceased',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data['JH']['districts']['Ranchi']['total']['conf'
                            'irmed'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        '${data['JH']['districts']['Ranchi']['total']['dece'
                            'ased'
                        ]}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50,),
            ],
          ),
        )
      ),
    );
  }
}
