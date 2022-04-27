import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Chip(
                backgroundColor: Colors.green.withOpacity(0.2),
                elevation: 12.0,
                autofocus: true,
                label: Text("BY  :  Shivam Choudhary",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                avatar: Icon(Icons.android),
              ),
              const Spacer(),
              Row(
                children: <Widget>[
                  IconButton(
                      icon: const Icon(MdiIcons.facebook,
                          size: 40.0, color: Colors.blue),
                      onPressed: () {
                        _launchUrl(
                            "https://www.facebook.com/shivamkumar.kumar.549668");
                      }),
                  const Spacer(),
                  IconButton(
                      icon: Icon(
                        MdiIcons.instagram,
                        size: 40.0,
                        color: const Color.fromRGBO(138, 58, 185, 4),
                      ),
                      onPressed: () {
                        _launchUrl(
                            "https://www.instagram.com/shivamchoudhary3690/");
                      }),
                  const Spacer(),
                  IconButton(
                      icon: const Icon(MdiIcons.twitter,
                          size: 40.0, color: Colors.lightBlue),
                      onPressed: () {
                        _launchUrl("https://twitter.com/S_Choudhary0369");
                      }),
                  const Spacer(),
                  IconButton(
                      icon: const Icon(MdiIcons.github,
                          size: 40.0, color: Colors.black87),
                      onPressed: () {
                        _launchUrl("https://github.com/ShivamChoudhary17");
                      }),
                  const Spacer(),
                  IconButton(
                      icon: Icon(MdiIcons.linkedin,
                          size: 40.0, color: Colors.blue),
                      onPressed: () {
                        _launchUrl(
                            "https://www.linkedin.com/in/theshivamchoudhary/");
                      })
                ],
              ),
              const Spacer(),
              GestureDetector(
                child: Chip(
                  backgroundColor: Colors.redAccent.withOpacity(0.2),
                  label: Text("  TECHNOLOGY USED   :   FLUTTER",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                  avatar: FlutterLogo(),
                ),
                onTap: () {
                  _launchUrl("https://flutter.dev/");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
