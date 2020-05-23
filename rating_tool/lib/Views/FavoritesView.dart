
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_tool/Components/movieCard.dart';
import 'package:rating_tool/Data_Classes/movie.dart';

class FavoritesView extends StatefulWidget{
  final String title;
  FavoritesView({this.title = "Favorites"});

  @override
  _FavoritesViewState createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView>{

  final Movie exampleMC = new Movie(
    id: 1,
    title: 'Das hässliche junge Entlein bla bla bla blaablaa',
    posterUrl: 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/gVOwl6Pswjg1VqqVrhmydL8nMyD.jpg',
    description: "Animated short film based on Andersen's tale.",
    releaseDate: DateTime.utc(1982, 7, 13),
  );

  final List<Movie> movies = new List();

  @override
  Widget build(BuildContext context) {
    movies.add(exampleMC);

    return Container(
      color: Color.fromRGBO(200, 200, 200, 1),
      child: movies.length > 0
          ? ListView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            onDismissed: (DismissDirection direction) {
              setState(() {
                print("deleted [$index]");
                movies.removeAt(index);
              });
            },
            secondaryBackground: Container(
              child: Center(
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              color: Colors.redAccent,
            ),
            background: Container(),
            child: MovieCard(movies[0]),
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
          );
        },
      )
          : Center(child: Text('No Items')),
    );
  }

}