import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';

import '../description.dart';

class UpComingPopular extends StatelessWidget {
  final List upComingPopular;

  const UpComingPopular({Key key, this.upComingPopular}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(
            text: 'UpComing Popular',
            color: Colors.black,
            size: 26,
          ),
          SizedBox(height: 10),
          Container(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: upComingPopular.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                      name: upComingPopular[index]['title'],
                                      bannerurl:
                                          'https://image.tmdb.org/t/p/w500' +
                                              upComingPopular[index]
                                                  ['backdrop_path'],
                                      posterurl:
                                          'https://image.tmdb.org/t/p/w500' +
                                              upComingPopular[index]
                                                  ['poster_path'],
                                      description: upComingPopular[index]
                                          ['overview'],
                                      vote: upComingPopular[index]
                                              ['vote_average']
                                          .toString(),
                                      launch_on: upComingPopular[index]
                                          ['release_date'],
                                    )));
                      },
                      child: Container(
                        width: 140,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          upComingPopular[index]
                                              ['poster_path']),
                                ),
                              ),
                              height: 200,
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(
                                upComingPopular[index]['title'] != null
                                    ? upComingPopular[index]['title']
                                    : "Loading",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
