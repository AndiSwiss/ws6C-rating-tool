import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_tool/Components/movieCard.dart';
import 'package:rating_tool/Data_Classes/movie.dart';
import 'package:rating_tool/Database/database_helper.dart';

class RatingsView extends StatefulWidget {
  final String title;
  RatingsView({this.title = "Ratings"});

  @override
  _RatingsViewState createState() => _RatingsViewState();
}

class _RatingsViewState extends State<RatingsView> {
  final dbHelper = DatabaseHelper.instance;

  /// Receives list of rated movies from db -- is then used in the FutureBuilder
  Future<List<Movie>> _getListOfRatedMoviesFromDb() async {
    var moviesFromDb = await dbHelper.getAllMovies();

    // return ONLY already rated movies
    return moviesFromDb.where((movie) => movie.isRated()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getListOfRatedMoviesFromDb(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Movie> movies = snapshot.data;

            return Container(
              color: Color.fromRGBO(200, 200, 200, 1),
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    onDismissed: (DismissDirection direction) {
                      setState(() {
                        print("deleted [$index]");
                        movies.removeAt(index);
                        //TODO: remove movie from db
                      });
                    },
                    secondaryBackground: Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      color: Color.fromRGBO(253, 104, 104, 1),
                    ),
                    background: Container(),
                    child: MovieCard(movies[index]),
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                  );
                },
              ),
            );
          } else {
            return Center(child: Text('No Items'));
          }
        });
  }
}
