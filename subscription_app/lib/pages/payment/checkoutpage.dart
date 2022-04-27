import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CheckOutPage extends StatefulWidget {
  final uid;
  final name;
  final id;
  final newname;
  final cost;
  final timestamp;
  final timestamp2;
  final status;
  const CheckOutPage({
    Key? key,
    required this.uid,
    required this.name,
    required this.id,
    required this.newname,
    required this.cost,
    required this.timestamp,
    required this.timestamp2,
    required this.status,
  }) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  var uuid = Uuid();
  Future makePay() async {
    /* Call API to GET and CHECK if USER is correct */
    var URL = Uri.parse(
        "https://www.jupitertouchlab.co.in/subscription/api/subsc_order.php");
    http.Response response = await http.post(URL,
        body: jsonEncode(<String, String>{
          "uid": widget.uid,
          "source":"flutter_app",
          //"order_id": uuid.v1().toString(),
          "cust_name": widget.name,
          "plan_id": widget.id,
          "plan_name": widget.newname,
          "plan_price": widget.cost,
          "start_date": widget.timestamp,
          "end_date": widget.timestamp2,
          "validity": widget.status
        }));

    print('uid${widget.uid}::::cust_name->${widget.name}');
    print(response.body);
    setState(() {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(response.body);
        if (data["ResponseCode"] == '200') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(data["ResponseMsg"]),
          ));
        } else if (data["ResponseCode"] == '401') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(data["ResponseMsg"]),
          ));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Image(
          image: AssetImage('images/logo.png'),
          width: 70.0,
          height: 70.0,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(5, 25, 5, 15),
              child: Container(
                height: 80,
                width: double.infinity,
                child: Card(
                  elevation: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('₹6000',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                        Text('1 month',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                        InkWell(
                          onTap: () {
                            makePay();
                          },
                          child: Text('Buy',
                              style: TextStyle(
                                  color: Colors.lightBlue.shade500,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
              child: Container(
                height: 80,
                width: double.infinity,
                child: Card(
                  elevation: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹15,000',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        Text('3 month',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                        Text('Buy',
                            style: TextStyle(
                                color: Colors.lightBlue.shade500,
                                fontWeight: FontWeight.w600,
                                fontSize: 18))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
              child: Container(
                height: 80,
                width: double.infinity,
                child: Card(
                  elevation: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('₹27,000',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                        Text('6 month',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                        Text('Buy',
                            style: TextStyle(
                                color: Colors.lightBlue.shade500,
                                fontWeight: FontWeight.w600,
                                fontSize: 18))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
              child: Container(
                height: 80,
                width: double.infinity,
                child: Card(
                  elevation: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('₹50,000',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                        Text('1 Year',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                        Text('Buy',
                            style: TextStyle(
                                color: Colors.lightBlue.shade500,
                                fontWeight: FontWeight.w600,
                                fontSize: 18))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
