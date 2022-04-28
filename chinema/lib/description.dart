import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';

class Description extends StatelessWidget {
  final String name, description, bannerurl, posterurl, vote, launch_on;

  const Description(
      {Key key,
      this.name,
      this.description,
      this.bannerurl,
      this.posterurl,
      this.vote,
      this.launch_on})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            child: ListView(
                children: [
              Container(
                  height: 250,
                  child: Stack(children: [
                    Positioned(
                      child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          bannerurl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 10,
                        child: Text('⭐ Average Rating - ' + vote,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600, fontSize: 16),)),
                  ])),
              SizedBox(height: 15),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      name != null ? name : 'Not Loaded',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600, fontSize: 24),)),
              Container(
                  padding: EdgeInsets.only(left: 10),
                  child:
                      Text('Releases On - ' + launch_on,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600, fontSize: 18),)),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      height: 200,
                      width: 100,
                      child: Image.network(posterurl),
                    ),
                  ),
                  Flexible(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          description, style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600, fontSize: 16),)),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
