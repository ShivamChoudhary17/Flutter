import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';
import 'package:movie_app_flutter/widgets/toprated.dart';
import 'package:movie_app_flutter/widgets/trending.dart';
import 'package:movie_app_flutter/widgets/tv.dart';
import 'package:movie_app_flutter/widgets/tvtop.dart';
import 'package:movie_app_flutter/widgets/upcomingpopuler.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.green),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apikey = '4ae94b3a8d16deb48527028327e0bd7a';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0YWU5NGIzYThkMTZkZWI0ODUyNzAyODMyN2UwYmQ3YSIsInN1YiI6IjYxNGQ0NzUwZTFmYWVkMDAyZDFlZTI4MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NizZ2zhpxR56JqS3Tuq1qbOOqv-Jpkrsq6VAQKb_MMg';
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];
  List tvTop = [];
  List upComingPopular = [];

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPouplar();
    Map tvresulttop = await tmdbWithCustomLogs.v3.tv.getTopRated();
    Map UpComingPopular = await tmdbWithCustomLogs.v3.movies.getUpcoming();
    print((UpComingPopular));
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
      tvTop = tvresulttop['results'];
      upComingPopular = UpComingPopular['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: modified_text(text: 'Cinema', color: Colors.black, size: 22),
            backgroundColor: Colors.transparent,
          ),
          body: ListView(
            children: [
              TV(upComingPopular: tv),
              TrendingMovies(
                trending: trendingmovies,
              ),
              UpComingPopular(
                upComingPopular: upComingPopular,
              ),
              TopRatedMovies(
                toprated: topratedmovies,
              ),
              TVTop(trending: tvTop,)
            ],
          )),
    );
  }
}
