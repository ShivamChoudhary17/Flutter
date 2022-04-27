import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/vacmodel.dart';
import '../ui/drawer.dart';

class ShowVac extends StatefulWidget {
  final date;
  final year;
  final month;
  final pin;
  const ShowVac(
      {Key? key,
      required this.date,
      required this.year,
      required this.month,
      required this.pin})
      : super(key: key);

  @override
  _ShowVacState createState() => _ShowVacState();
}

class _ShowVacState extends State<ShowVac> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getJsonData();
    });
  }

  List<VacModel> vacModelList = <VacModel>[];

  Future getJsonData() async {
    String d = widget.date;
    String m = widget.month;
    String y = widget.year;
    String pin = widget.pin;
    var url = "https://cdn-api.co-vin"
        ".in/api/v2/appointment/sessions/public/findByPin?pincode=$pin&date=$d"
        "-$m-$y";
    http.Response responce = await http.get(Uri.parse(url));
    Map data = json.decode(responce.body);
    setState(() {
      for (Map e in data['sessions']) {
        try {
          VacModel vacModel = VacModel();
          vacModel = VacModel.fromMap(e);
          vacModelList.add(vacModel);
        } catch (e) {
          print('ERROR IS:::$e');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.lightGreenAccent),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
      body: /*data == null
          ? Center(
              child: FadingText(
                'Stay safe during the pandemic...',
                style: const TextStyle(
                  letterSpacing: 3.0,
                ),
              ),
            )
          :*/
          ListView.builder(
              itemCount: vacModelList.length,
              itemBuilder: (BuildContext context, int index) {
                return buildCard(context, index);
              }),
    );
  }

  Widget buildCard(BuildContext context, int index) {
    return Card(
      borderOnForeground: true,
      elevation: 16,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 14,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Center Name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  vacModelList[index].name,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.8)),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text('From',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),), Text('To',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  vacModelList[index].from,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.8)),
                ),
                Text(
                  vacModelList[index].to,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.8)),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text('Fee Type',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),), Text('Date',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  vacModelList[index].feeType,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.8)),
                ),
                Text(
                  vacModelList[index].vacDate,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.8)),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text('Available Capacity',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),), Text('Fee',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  vacModelList[index].available,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.8)),
                ),
                Text(
                  vacModelList[index].cost.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.8)),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  const [
                Text('Vaccine Name',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),),
                Text('MIN Age',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text(vacModelList[index].vaccine,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.8)),),
                Text(vacModelList[index].minAgeLimit,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.8)),)
              ],
            ),
            const SizedBox(
              height: 14,
            ),

            Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Slots',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),),
                const SizedBox(height: 8,),
                Text(
                  vacModelList[index].slots1 ,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.8)),
                ),
                    Text(
                      vacModelList[index].slots2,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.8)),
                    ),
                    Text(
                      vacModelList[index].slots3,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.8)),
                    )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
