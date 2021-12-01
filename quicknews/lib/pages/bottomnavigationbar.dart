import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quicknews/pages/searchpage.dart';

import 'about.dart';
import 'home.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int index = 1;
  final screen = [
    AboutPage(),
    Home(),
    SearchPage(),
  ];
  final items = [
    Icon(Icons.info_outlined),
    Icon(Icons.home_filled),
    Icon(Icons.search),
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      body: screen[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Colors.white)
        ),
        child: CurvedNavigationBar(
          color: Theme.of(context).primaryColor,
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
        height: 50,
        index: index,
        items: items,
        onTap: (index) => setState(() => this.index = index),
    ),
      ),
    );
  }
}
