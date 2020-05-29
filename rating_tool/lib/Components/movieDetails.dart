import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_tool/Data_Classes/movie.dart';
import 'package:rating_tool/Database/database_helper.dart';

class MovieDetails extends StatefulWidget {
  final String title;

  MovieDetails({this.title = "Movie Rating Tool"});

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    Movie movie = ModalRoute.of(context).settings.arguments;
    final dbHelper = DatabaseHelper.instance;

    /// Adds or updates a rated movie in the db
    void _addOrUpdateMovieInDb() async {
      // First, try to insert the movie:
      final inserted = await dbHelper.insert(movie);
      if (inserted != -1) {
        print("Movie ${movie.id} - '${movie.title}' was inserted in to db.");
      }
      // If already present, update the movie:
      else {
        final updated = await dbHelper.update(movie);
        if (updated == 1) {
          print("Movie ${movie.id} - ${movie.title} was updated in the db.");
        } else {
          print(
              "Shouldn't have happened: When trying to update the movie ${movie.title} "
              "with movie.id ${movie.id}, the return-value of 'updated' was $updated "
              "(should have been 1)!");
        }
      }
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: new NetworkImage(movie.posterUrl),
          fit: BoxFit.fill,
        )),
        //background image blur effect
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
              color: Colors.black.withOpacity(.69),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Column(children: <Widget>[
                          SizedBox(height: 100),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: movie.poster,
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 20,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.favorite_border,
                                      color: Color.fromRGBO(253, 104, 104, 1),
                                      size: 40,
                                    ),
                                    onPressed: () {
                                      // TODO: write here the action for adding the movie to the favorites lists in the db
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 8, 5, 0),
                                      child: Text(
                                        movie.title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32,
                                          color:
                                              Color.fromRGBO(249, 245, 227, 1),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12, 14, 12, 8),
                                      child: Text(
                                        movie.description,
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                        maxLines: 6,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ]),
                      ),
                      Align(
                        alignment: Alignment(-0.90, -0.88),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            height: 36,
                            width: 36,
                            color: Colors.white.withOpacity(.8),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              color: Colors.black87,
                              iconSize: 20,
                              onPressed: () {
                                if (movie.isRated()) {
                                  _addOrUpdateMovieInDb();
                                }
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                      ),
                      DraggableScrollableSheet(
                        initialChildSize: 0.2,
                        minChildSize: 0.2,
                        maxChildSize: 1.0,
                        expand: true,
                        builder: (context, scrollController) {
                          return SingleChildScrollView(
                            controller: scrollController,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 24),
                              constraints: BoxConstraints(
                                minHeight: MediaQuery.of(context).size.height,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                color: Color.fromRGBO(35, 35, 35, 1),
                              ),
                              child: Column(
                                children: <Widget>[
                                  ImageIcon(
                                    AssetImage("assets/rating.png"),
                                    color: Color.fromRGBO(87, 58, 96, 1),
                                    size: 40,
                                    semanticLabel: "Rating",
                                  ),
                                  SizedBox(height: 30),
                                  Text("Abstractness",
                                      style: TextStyle(color: Colors.white)),
                                  Slider(
                                    onChanged: (double value) {
                                      setState(
                                          () => movie.abstractness = value);
                                    },
                                    value: movie.abstractness,
                                    max: 100,
                                    min: 0,
                                    inactiveColor: Colors.white10,
                                    activeColor:
                                        Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                  Text("Cinematography",
                                      style: TextStyle(color: Colors.white)),
                                  Slider(
                                    onChanged: (double value) {
                                      setState(
                                          () => movie.cinematography = value);
                                    },
                                    value: movie.cinematography,
                                    max: 100,
                                    min: 0,
                                    inactiveColor: Colors.white10,
                                    activeColor:
                                        Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                  Text("Complexity",
                                      style: TextStyle(color: Colors.white)),
                                  Slider(
                                    onChanged: (double value) {
                                      setState(() => movie.complexity = value);
                                    },
                                    value: movie.complexity,
                                    max: 100,
                                    min: 0,
                                    inactiveColor: Colors.white10,
                                    activeColor:
                                        Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                  Text("Darkness",
                                      style: TextStyle(color: Colors.white)),
                                  Slider(
                                    onChanged: (double value) {
                                      setState(() => movie.darkness = value);
                                    },
                                    value: movie.darkness,
                                    max: 100,
                                    min: 0,
                                    inactiveColor: Colors.white10,
                                    activeColor:
                                        Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                  Text("Humor",
                                      style: TextStyle(color: Colors.white)),
                                  Slider(
                                    onChanged: (double value) {
                                      setState(() => movie.humor = value);
                                    },
                                    value: movie.humor,
                                    max: 100,
                                    min: 0,
                                    inactiveColor: Colors.white10,
                                    activeColor:
                                        Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                  Text("Realism",
                                      style: TextStyle(color: Colors.white)),
                                  Slider(
                                    onChanged: (double value) {
                                      setState(() => movie.realism = value);
                                    },
                                    value: movie.realism,
                                    max: 100,
                                    min: 0,
                                    inactiveColor: Colors.white10,
                                    activeColor:
                                        Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                  Text("Suspense",
                                      style: TextStyle(color: Colors.white)),
                                  Slider(
                                    onChanged: (double value) {
                                      setState(() => movie.suspense = value);
                                    },
                                    value: movie.suspense,
                                    max: 100,
                                    min: 0,
                                    inactiveColor: Colors.white10,
                                    activeColor:
                                        Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                  Text("Wokeness",
                                      style: TextStyle(color: Colors.white)),
                                  Slider(
                                    onChanged: (double value) {
                                      setState(() => movie.wokeness = value);
                                    },
                                    value: movie.wokeness,
                                    max: 100,
                                    min: 0,
                                    inactiveColor: Colors.white10,
                                    activeColor:
                                        Color.fromRGBO(200, 200, 200, 1),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
}
