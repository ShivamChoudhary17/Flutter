import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';

import '../description.dart';

class TVTop extends StatelessWidget {
  final List trending;

  const TVTop({Key key, this.trending}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(
            text: 'TV Top Rated',
            color: Colors.black,
            size: 26,
          ),
          SizedBox(height: 10),
          Container(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trending.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                      name: trending[index]['name'],
                                      bannerurl: trending[index]
                                                  ['backdrop_path'] ==
                                              null
                                          ? 'https://image.tmdb.org/t/p/w500' +
                                              trending[index]['poster_path']
                                          : 'https://image.tmdb.org/t/p/w500' +
                                              trending[index]['backdrop_path'],
                                      posterurl:
                                          'https://image.tmdb.org/t/p/w500' +
                                              trending[index]['poster_path'],
                                      description: trending[index]['overview'],
                                      vote: trending[index]['vote_average']
                                          .toString(),
                                      launch_on: trending[index]
                                          ['first_air_date'],
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
                                          trending[index]['poster_path']),
                                ),
                              ),
                              height: 200,
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(
                                trending[index]['name'] != null
                                    ? trending[index]['name']
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
