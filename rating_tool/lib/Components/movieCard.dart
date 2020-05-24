
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rating_tool/Data_Classes/movie.dart';


class MovieCard extends StatelessWidget{

  final Movie movie;

  MovieCard(this.movie);

  var formatter = new DateFormat();

  @override
  Widget build(BuildContext context) {
    print(movie.posterUrl);
    return GestureDetector(
      onTap: () {
        print(movie.title);
        //TODO: open movie details
      },
      child: Container(
        height: 120,
        child: Card(
          color: Color.fromRGBO(55, 55, 55, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.symmetric(vertical: 0.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              movie.posterUrl != null ? Container(
                width: 80,
                child: Image(
                  image: NetworkImage(movie.posterUrl),
                ),
              ) : Container(
                width: 80,
                color: Color.fromRGBO(87, 58, 96, 1),
              ),
              SizedBox(width: 18),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 4, 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(250, 250, 250, 1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        child: Text(
                          DateFormat.yMMMd().format(movie.releaseDate).toString(), style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
