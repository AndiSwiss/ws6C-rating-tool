import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rating_tool/Components/moviePoster.dart';
import 'package:rating_tool/Components/searchBar.dart';
import 'package:rating_tool/Data_Classes/movie.dart';
import 'package:http/http.dart' as http;

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  Map<String, dynamic> apiResponse;
  List<dynamic> results;
  List<MoviePoster> posters = new List<MoviePoster>();
  int page = 1;
  String searchQuery = "";
  bool loading = false;

  ScrollController _controller;

  void initState() {
    super.initState();
    _controller = new ScrollController();
    //reset("");
    _controller.addListener(() {
      //debugPrint(_controller.position.pixels.toString() + " -- " +  _controller.position.maxScrollExtent.toString());
      //debugPrint((_controller.position.pixels >= _controller.position.maxScrollExtent - 100).toString());
      //if ((_controller.position.atEdge) ) {
      if (!loading &&
          _controller.position.pixels >=
              _controller.position.maxScrollExtent - 400) {
        loading = true;
        page++;
        getMovies();
      }

      //check scrolling direction
      if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          setState(() {
            isScrollingDown = true;
            _show = false;
          });
        }
      }
      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          setState(() {
            isScrollingDown = false;
            _show = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    super.dispose();
  }

  void reset(String query) {
    posters.clear();
    searchQuery = query;
    _controller.jumpTo(0);
    page = 1;
  }

  void getMovies() async {
    debugPrint(searchQuery);
    debugPrint("Getting Movies...");
    String url =
        "https://api.themoviedb.org/3/search/movie?api_key=2a5e9e9ffe88a72d360c94f040190e21&query=$searchQuery&page=$page";
    debugPrint(url);
    final response = await http.get(url);
    debugPrint("Fetch ok");
    if (response.statusCode == 200) {
      debugPrint("status ok");
      apiResponse = json.decode(response.body);
      if (apiResponse["total_pages"] >= page) {
        results = apiResponse["results"];
        //debugPrint(results.toString());
        setState(() {
          results.forEach((m) => {
                //debugPrint(m["release_date"].toString()),
                posters.add(new MoviePoster(Movie(
                  title: m["title"],
                  posterUrl: m["poster_path"],
                  id: m["id"],
                  description: m["overview"],
                  releaseDate: DateTime.parse((m["release_date"] != ""
                          ? m["release_date"]
                          : "1200-01-01")
                      .replaceAll(RegExp('-'), '')),
                )))
              });
        });
      }
      loading = false;
    }
  }

  //default = search/home
//  int _selectedIndex = 1;

  //change activeIndex
//  void _onTap(int index){
//    setState(() {
//      _selectedIndex = index;
//    });
//    print("active index: "+_selectedIndex.toString());
//  }

  //show/hide appBar variables
  bool _show = true;
  bool isScrollingDown = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                      children: <Widget>[
                        _show ? SizedBox(height: 68) : SizedBox(height: 0),
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
        _show
            ? SearchBar(
                onSubmit: (text) => {reset(text), getMovies()},
              )
            : SizedBox(),
      ],
    );
  }
}
