

import 'package:flutter/material.dart';
import 'package:rating_tool/Data_Classes/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MoviePoster extends StatelessWidget {
  final Movie movie;

  MoviePoster(this.movie);


  @override
  Widget build(BuildContext context) {
    //Base URL for Images TMDB:
    //https://image.tmdb.org/t/p/w342   + /xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg

    //compute poster size based on screen size
    //poster width/height ratio = 1.5
    double screenWidth  = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double posterWidth  = (screenWidth/2);
    double posterHeight = posterWidth*1.5;


    return Container(
        height: posterHeight,
        width: posterWidth,
        child: GestureDetector(
          child: movie.posterUrl != null
              ? Center(
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.black54),
                        strokeWidth: 4,
                        //backgroundColor: Color.fromRGBO(230,230,230,1),
                      ),
                  imageUrl: movie.posterUrl,
                ),
              )
              : Container(
                  color: Color.fromRGBO(45, 47, 49, 1),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(movie.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)))),
          onTap: () {
            Navigator.of(context).pushNamed("/details", arguments: movie);
          },
        ));
  }
}
