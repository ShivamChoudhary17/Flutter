import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_indicators/progress_indicators.dart';

import '../ui/drawer.dart';
import 'displayvac.dart';

class CheckVac extends StatefulWidget {
  const CheckVac({Key? key}) : super(key: key);

  @override
  _CheckVacState createState() => _CheckVacState();
}

class _CheckVacState extends State<CheckVac> {
  TextEditingController datecontroller = TextEditingController();
  TextEditingController monthcontroller = TextEditingController();
  TextEditingController yearcontroller = TextEditingController();
  TextEditingController pincontroller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.lightGreenAccent),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 320,
              width: 400,
              child: Image.asset(
                  'images/gyourvac.jpg'),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 80,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Date',
                    ),
                    keyboardType: TextInputType.number,
                    controller: datecontroller,
                    autofocus: true,
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Month',
                    ),
                    keyboardType: TextInputType.number,
                    controller: monthcontroller,
                    autofocus: true,
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Year',
                    ),
                    keyboardType: TextInputType.number,
                    controller: yearcontroller,
                    autofocus: true,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ), SizedBox(
              width: 200,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'PIN Code',
                ),
                keyboardType: TextInputType.number,
                controller: pincontroller,
                autofocus: true,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 40,
              width: 120,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ShowVac(
                      month: monthcontroller.text,
                      year: yearcontroller.text,
                      date: datecontroller.text,
                      pin: pincontroller.text,
                    );
                  }));
                },
                child: const Text('Check',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
