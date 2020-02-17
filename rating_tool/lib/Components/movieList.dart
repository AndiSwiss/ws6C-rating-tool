import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rating_tool/Components/moviePoster.dart';
import 'package:rating_tool/Data_Classes/movie.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  Map<String, dynamic> apiResponse;
  List<dynamic> results;
  List<MoviePoster> posters = new List<MoviePoster>();

  void initState() {
    super.initState();
  }

  void getMovies() async {
    debugPrint("Getting Movies...");
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=2a5e9e9ffe88a72d360c94f040190e21";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      apiResponse = json.decode(response.body);
      results = apiResponse["results"];
      //debugPrint(results.toString());
      setState(() {
        results.forEach((m) => {
              posters.add(new MoviePoster(Movie(m["title"], m["poster_path"])))
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FlatButton(onPressed: getMovies, child: Text("Get Movies")),
              Wrap(
                children: <Widget>[
                  ...posters,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
