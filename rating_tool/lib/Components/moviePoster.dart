import 'package:flutter/material.dart';
import 'package:rating_tool/Data_Classes/movie.dart';

class MoviePoster extends StatelessWidget {
  Movie movie;

  MoviePoster(this.movie);

  @override
  Widget build(BuildContext context) {
    //Base URL for Images TMDB:
    //https://image.tmdb.org/t/p/w342   + /xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg
    return Container(
        height: 513 / 2.5,
        width: 342 / 2.5,
        child: GestureDetector(
          child: movie.poster,
          onTap: () {
            Navigator.of(context).pushNamed("/details", arguments: movie);
          },
        ));
  }
}
