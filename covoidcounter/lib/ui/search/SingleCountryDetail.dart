import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleCountryDetail extends StatefulWidget {
  var data;
  SingleCountryDetail(this.data);

  @override
  _SingleCountryDetail createState() => _SingleCountryDetail(this.data);
}

class _SingleCountryDetail extends State<SingleCountryDetail> {

  var data, index;
  _SingleCountryDetail(this.data,);
  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Can't Open URL"),
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
          centerTitle: true,
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
                Text("Counter",
                  style: TextStyle(
                      color: Colors.green.shade400
                  ),),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 30,
            ),
            Text(
              data['country'],
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              color: Colors.redAccent,
              height: 95,
              width: 142,
              child: Image(
                fit: BoxFit.fill,
                image: NetworkImage(data['countryInfo']['flag']),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Card(
                    elevation: 16,
                    child: Container(
                      height: 80,
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Cases",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black),
                            ),
                            Text(
                              "${data['cases']}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Card(
                    elevation: 16,
                    child: Container(
                      height: 80,
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Deaths",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black),
                            ),
                            Text(
                              "${data['deaths']}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Card(
                    elevation: 16,
                    child: Container(
                      height: 80,
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recovered",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black),
                            ),
                            Text(
                              "${data['recovered']}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Card(
                    elevation: 16,
                    child: Container(
                      height: 80,
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Active",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black),
                            ),
                            Text(
                              "${data['active']}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Card(
                    elevation: 16,
                    child: Container(
                      height: 80,
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Critical",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black),
                            ),
                            Text(
                              "${data['critical']}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Card(
                    elevation: 16,
                    child: Container(
                      height: 80,
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Today Cases",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black),
                            ),
                            Text(
                              "${data['todayCases']}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Card(
                    elevation: 16,
                    child: Container(
                      height: 80,
                      width: 343,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Today Recovered",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black),
                            ),
                            Text(
                              "${data['todayRecovered']}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            MaterialButton(
              onPressed: () {
                _launchUrl('https://www.worldometers.info/coronavirus/');
              },
                child: Text(
                  "Learn More",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade600,
                  ),
                ),
              ),
            SizedBox(height: 30,),
          ]),

          )),
        );

  }
}
