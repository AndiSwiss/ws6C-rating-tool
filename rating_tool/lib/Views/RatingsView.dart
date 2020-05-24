
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_tool/Components/movieCard.dart';
import 'package:rating_tool/Data_Classes/movie.dart';

class RatingsView extends StatefulWidget{
  final String title;
  RatingsView({this.title = "Ratings"});

  @override
  _RatingsViewState createState() => _RatingsViewState();
}

class _RatingsViewState extends State<RatingsView>{

  //TODO: receive list of rated movies from db
  //

  final List<Movie> movies = new List();

  @override
  Widget build(BuildContext context) {

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
      )
          : Center(child: Text('No Items')),
    );
  }

}