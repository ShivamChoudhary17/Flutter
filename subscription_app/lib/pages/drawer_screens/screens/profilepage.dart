import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibgyor/pages/notification_page/notification.dart';

import '../../../models/usermodel/user.dart';
import '../navigation_drawer.dart';

class ProfilePage extends StatefulWidget {
  final UID;
  const ProfilePage({Key? key, this.UID}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  bool isLoading = true;
  String Email = '';
  String Name = '';
  String Contact = '';
  String bankName = '';
  String bankAccNo = '';
  String ifscCode = '';
  String bankBranch = '';
  String Location = '';
  String panNo = '';



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //initial();
    TestUser();
    setState(() {});
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }

/*  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      uid = logindata.getString('UID')??'hello';
    });
    print('user  UID:::$uid');
  }*/

  List<User> userModelList = <User>[];
  Map<String, dynamic> data={};
  late SharedPreferences logindata;

  Future TestUser() async {
    String uid = widget.UID.toString();
    final url1 = Uri.parse(
        'https://www.jupitertouchlab.co.in/subscription/api/userdata.php');
    Response response =
        await http.post(url1, body: jsonEncode(<String, String>{"uid": uid}));
    data = json.decode(response.body);
    setState(() {
      isLoading = false;
    });
    //print('DATA ISSS::::::${data['user']}');
/*    setState(() {
      for (Map element in data['user']) {
        print('ELEMENT ISSS::::$element');
        try {
          User userModel = User();
          userModel = User.fromMap(element);
          userModelList.add(userModel);

        } catch (e) {
          print('in catch:  ${e}');
        }
        ;
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () => Scaffold.of(context).openDrawer()),
          ),
          title: const Image(
            image: AssetImage('images/logo.png'),
            width: 70.0,
            height: 70.0,
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.notifications_active),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NotificationView();
                  }));
                }),
          ],
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.grey,
        ),
        drawer: const NavigationDrawer(),
        body: isLoading? Center(child: CircularProgressIndicator(),):Container(
          child: Padding(
            padding: EdgeInsets.only(top: 28),
            child: Column(
              children: [
                Center(
                  child: Text('Your Detail',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),),
                ),
                SizedBox(height: 30,),
                Column(
                  children: [
                    Text('Name',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Schyler',
                          fontSize: 22),),
                    Text("${data['user']['fullname']}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.black.withOpacity(0.6)),),
                    SizedBox(
                      height: 23,
                      child: Divider(
                        height: 6,
                        color: Colors.grey.shade500,
                        thickness: 2,
                        indent: 58,
                      ),
                    ),
                    Text('UID',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Schyler',
                          fontSize: 22),),
                    Text("${data['user']['uid']}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.black.withOpacity(0.6)),),
                    SizedBox(
                      height: 23,
                      child: Divider(
                        height: 6,
                        color: Colors.grey.shade500,
                        thickness: 1,
                        endIndent: 58,
                      ),
                    ),
                    Text('Email ID',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Schyler',
                          fontSize: 22),),
                    Text("${data['user']['email']}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.black.withOpacity(0.6)),),
                    SizedBox(
                      height: 23,
                      child: Divider(
                        height: 6,
                        color: Colors.grey.shade500,
                        thickness: 2,
                        indent: 58,
                      ),
                    ),
                    Text('Bank Name',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Schyler',
                          fontSize: 22),),
                    Text("${data['user']['bank_name']}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.black.withOpacity(0.6)),),
                    SizedBox(
                      height: 23,
                      child: Divider(
                        height: 6,
                        color: Colors.grey.shade500,
                        thickness: 1,
                        endIndent: 58,
                      ),
                    ),
                    Text('Bank Account Number',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Schyler',
                          fontSize: 22),),
                    Text("${data['user']['bank_acc_no']}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.black.withOpacity(0.6)),),
                    SizedBox(
                      height: 23,
                      child: Divider(
                        height: 6,
                        color: Colors.grey.shade500,
                        thickness: 2,
                        indent: 58,
                      ),
                    ),
                    Text('IFDC Code',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Schyler',
                          fontSize: 22),),
                    Text("${data['user']['ifsc_code']}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.black.withOpacity(0.6)),),
                    SizedBox(
                      height: 23,
                      child: Divider(
                        height: 6,
                        color: Colors.grey.shade500,
                        thickness: 1,
                        endIndent: 58,
                      ),
                    ),
                    Text('Pan Number',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Schyler',
                          fontSize: 22),),
                    Text("${data['user']['panno']}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.black.withOpacity(0.6)),),
                  ],
                )
              ],
            ),
          ),
        )















    );
  }

  Widget buildCard(BuildContext context, int index) {
    return Card(
        elevation: 16,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 38.0),
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                         Text(
                          data['user']['id'],

                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(26.0),
                            child: SizedBox(
                              width: 400,
                              height: 700,
                              child: Card(
                                elevation: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    Text(
                                      'Name',
                                      //'Name $Name',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      userModelList[index].fullname,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 23,
                                      child: Divider(
                                        height: 6,
                                        color: Colors.grey.shade500,
                                        thickness: 1,
                                        indent: 58,
                                      ),
                                    ),
                                    Text(
                                      'Unique ID , ',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      userModelList[index].id,
                                      // Uid,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 23,
                                      child: Divider(
                                        height: 6,
                                        color: Colors.grey.shade500,
                                        thickness: 1,
                                        endIndent: 58,
                                      ),
                                    ),
                                    Text(
                                      'Email: ',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      userModelList[index].email,
                                      // Email,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 23,
                                      child: Divider(
                                        indent: 58,
                                        height: 6,
                                        color: Colors.grey.shade500,
                                        thickness: 1,
                                      ),
                                    ),
                                    Text(
                                      userModelList[index].bank_acc_no,
                                      // 'Bank Account Number: ',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      bankAccNo,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 23,
                                      child: Divider(
                                        endIndent: 59,
                                        height: 6,
                                        color: Colors.grey.shade500,
                                        thickness: 1,
                                      ),
                                    ),
                                    Text(
                                      userModelList[index].contact,
                                      // 'Mobile No: ',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      Contact,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 23,
                                      child: Divider(
                                        indent: 58,
                                        height: 6,
                                        color: Colors.grey.shade500,
                                        thickness: 1,
                                      ),
                                    ),
                                    const Text(
                                      'Bank Name: ',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      bankName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 23,
                                      child: Divider(
                                        endIndent: 58,
                                        height: 6,
                                        color: Colors.grey.shade500,
                                        thickness: 1,
                                      ),
                                    ),
                                    const Text(
                                      'IFSC Code: ',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      userModelList[index].ifsc_code,
                                      //ifscCode,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 23,
                                      child: Divider(
                                        indent: 58,
                                        height: 6,
                                        color: Colors.grey.shade500,
                                        thickness: 1,
                                      ),
                                    ),
                                    const Text(
                                      'Location: ',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      userModelList[index].location,
                                      // Location,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 23,
                                      child: Divider(
                                        height: 6,
                                        color: Colors.grey.shade500,
                                        thickness: 1,
                                        endIndent: 58,
                                      ),
                                    ),
                                    const Text(
                                      'Branch Name: ',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      userModelList[index].bank_branch,
                                      // bankBranch,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ])));
  }
}
