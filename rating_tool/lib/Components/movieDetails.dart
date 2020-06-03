import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_tool/Components/rankingDraggableSheet.dart';
import 'package:rating_tool/Components/favoriteIconButton.dart';
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

    /// Searches a movie in the db -- is then used in the FutureBuilder
    Future<Movie> _searchMovieInDB() async {
      return await dbHelper.getMovie(movie.id);
    }

    /// Adds or updates a rated movie in the db
    void _addOrUpdateMovieInDb() async {
      // First, try to insert the movie:
      final inserted = await dbHelper.insert(movie);
      if (inserted != -1) {
        debugPrint(
            "Movie ${movie.id} - '${movie.title}' was inserted in to db.");
      }
      // If already present, update the movie:
      else {
        final updated = await dbHelper.update(movie);
        if (updated == 1) {
          debugPrint(
              "Movie ${movie.id} - ${movie.title} was updated in the db.");
        } else {
          debugPrint(
              "Shouldn't have happened: When trying to update the movie ${movie.title} "
              "with movie.id ${movie.id}, the return-value of 'updated' was $updated "
              "(should have been 1)!");
        }
      }
    }

    return Scaffold(
      body: FutureBuilder(
        future: _searchMovieInDB(),
        builder: (context, snapshot) {
          // The following is necessary for the case when one wants to unfavor
          // an already favored movie (which is already in the db):
          bool isFromDB = false;

          // If the movie is already in the the database, overwrite the 'movie'
          // with data from the database:
          if (snapshot.hasData) {
            movie = snapshot.data;
            isFromDB = true;
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: movie.posterUrl != null && movie.posterUrl != ""
                    ? NetworkImage(movie.posterUrl)
                    : AssetImage("assets/empty.png"),
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
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: GestureDetector(
                                          onTap: () => Navigator.of(context).pushNamed("/image", arguments: movie.posterUrl),
                                            child: movie.poster),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                              3 -
                                          20,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: FavoriteIconButton(movie: movie),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 8, 5, 0),
                                            child: Text(
                                              movie.title,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 32,
                                                color: Color.fromRGBO(
                                                    249, 245, 227, 1),
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
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                      if (movie.isRated() ||
                                          movie.isFavorite() ||
                                          isFromDB) {
                                        _addOrUpdateMovieInDb();
                                      }
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ),
                            ),
                            RankingDraggableWidget(movie),
                          ],
                        ))),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
