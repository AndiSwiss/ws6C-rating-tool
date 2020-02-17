import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rating_tool/Components/searchBar.dart';

import 'Components/moviePoster.dart';
import 'Data_Classes/movie.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Rating Tool',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: 'Movie Rating Tool'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> apiResponse;
  List<dynamic> results;
  List<MoviePoster> posters = new List<MoviePoster>();


  void initState() {
    super.initState();
  }

  /**
   * Clears and sets the posters list.
   * Makes a HTTP GET request to get all movies matching the query.
   */
  void getMovies(String searchQuery) async {
    posters.clear();
    debugPrint("Getting Movies...");
    String url =
        "https://api.themoviedb.org/3/search/movie?api_key=2a5e9e9ffe88a72d360c94f040190e21";
    final response = await http.get(url + "&query=" + searchQuery);
    if (response.statusCode == 200) {
      apiResponse = json.decode(response.body);
      if (apiResponse["total_results"] > 0) {
        results = apiResponse["results"];
        //debugPrint(results.toString());
        setState(() {
          results.forEach((m) => {
                posters
                    .add(new MoviePoster(Movie(m["title"], m["poster_path"])))
              });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SearchBar(
              onSubmit: (text) => {getMovies(text)},
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  //TODO Add scrollcontroller for infinite scroll and image fetching 
                  //controller: _controller,
                  child: Column(
                    children: <Widget>[
                      Wrap(
                        children: <Widget>[
                          ...posters,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
