import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:covoidcounter/ui/bottomnavbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.redAccent,
      ),
      title: "COVID19 Tracker",
      home: AnimatedSplashScreen(
          splashTransition: SplashTransition.scaleTransition,
          nextScreen: BottomNavigation(),
          splash: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 60,
              width: 60,
              child: Image.asset(
                'images/covid-19.png',
              ),
            ),
            Text(
              'Counter',
              style: TextStyle(
                  color: Colors.green.shade400,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ])),
    );
  }
}
