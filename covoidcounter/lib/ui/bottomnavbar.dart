import 'package:flutter/material.dart';
import '../india/allstate.dart';
import 'HomeScreen.dart';
import 'News.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _BottomNavigation();
  }
}

class _BottomNavigation extends State<BottomNavigation> {
  int tabSelected = 1; // index to iterate and select items in screen List
  @override
  Widget build(BuildContext context) {
    var screens = [
      // Stores different screens to show in Bottom_Nav_Bar
      AllState(),
      HomeScreen(),
      NewsPage(),
    ];

    return Scaffold(
      body: Container(
        child: screens[tabSelected],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.redAccent.shade200,
          backgroundColor: Colors.transparent,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ),
        child: NavigationBar(
          height: 60,
          selectedIndex: tabSelected,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          animationDuration: const Duration(seconds: 2),
          onDestinationSelected: (index) {
            setState(() {
              tabSelected = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.insights,
                color: Colors.green,
              ),
              label: 'India',
              selectedIcon: Icon(Icons.insights_outlined),
            ),
            NavigationDestination(
              icon: Icon(
                Icons.home_filled,
                color: Colors.green,
              ),
              label: 'Home',
              selectedIcon: Icon(Icons.home_outlined),
            ),
            NavigationDestination(
              icon: Icon(
                Icons.article_rounded,
                color: Colors.green,
              ),
              label: 'News',
              selectedIcon: Icon(Icons.article_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
