import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'SingleCountryDetail.dart';

class CountryCard extends StatefulWidget {
  final data;
  CountryCard(this.data);
  @override
  _CountryCard createState() => _CountryCard();
}

class _CountryCard extends State<CountryCard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.greenAccent),
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
              Text(
                "Counter",
                style: TextStyle(color: Colors.green.shade400),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 16, 10, 10),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                SingleCountryDetail(widget.data)));
          },

          child: Card(
            child: ListTile(
              leading: Container(
                height: 50,
                width: 70,
                color: Colors.deepPurpleAccent,
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.data['countryInfo']['flag']),
                ),
              ),
              title: Text(
                widget.data['country'],
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
                "${widget.data['cases']}",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600),
              ),
            ),
          ),
          //)
        ),
      ),
    ));
  }
}
