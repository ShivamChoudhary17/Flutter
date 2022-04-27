import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../about.dart';
import 'fav.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SpecialPage()));
                },
                child: createDrawerBodyItem(icon: Icons.favorite, text: 'Favorite', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SpecialPage()));
                }),
              ),
              createDrawerBodyItem(icon: Icons.account_circle, text: 'About '
                  'Us', onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage())); }),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text(
                  'App version 1.0.2',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black54),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createDrawerBodyItem(
      {required IconData icon, required String text, required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon, color: Colors.green,),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w800
            ),),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
