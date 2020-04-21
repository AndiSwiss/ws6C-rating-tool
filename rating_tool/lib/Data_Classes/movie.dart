import 'package:flutter/Material.dart';

class Movie {
  int id;
  String title;
  DateTime releaseDate;
  String description;
  String posterUrl;
  Image poster;
  double abstractness = 50;
  double cinematography = 50;
  double romanticness = 50;
  double complexity = 50;
  double darkness = 50;
  double humor = 50;
  double realism = 50;
  double suspense = 50;
  double wokeness = 50;

  Movie(
      {this.id,
      this.title,
      this.posterUrl,
      this.releaseDate,
      this.description}) {
    if (this.posterUrl != null) {
      this.posterUrl = "https://image.tmdb.org/t/p/w342" + this.posterUrl;
      this.poster = Image.network(posterUrl);
    }
    //Placeholder => should be cached offline => temporary
    else
      this.poster = Image(image: AssetImage("assets/empty.png"));
  }
}
