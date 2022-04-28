import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';

class TopRatedMovies extends StatelessWidget {
  final List toprated;

  const TopRatedMovies({Key key, this.toprated}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(
            text: 'All Time Popular',
            size: 26,
            color: Colors.black,
          ),
          SizedBox(height: 10),
          Container(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: toprated.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 140,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500' +
                                        toprated[index]['poster_path']),
                              ),
                            ),
                            height: 200,
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: Text(
                                toprated[index]['title'] != null
                                    ? toprated[index]['title']
                                    : 'Loading',
                              style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.w600),),
                          )
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
