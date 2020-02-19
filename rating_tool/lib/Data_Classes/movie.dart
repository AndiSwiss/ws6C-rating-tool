import 'package:flutter/Material.dart';

class Movie {
  String title;
  String posterUrl;
  Image poster;

  Movie(this.title, this.posterUrl) {
    if(this.posterUrl != null) {
      this.posterUrl = "https://image.tmdb.org/t/p/w342" + this.posterUrl;
      this.poster = Image.network(posterUrl);
    }
    //Placeholder => should be cached offline => temporary
    else this.poster = Image(image: AssetImage("assets/empty.png"));
  }
}