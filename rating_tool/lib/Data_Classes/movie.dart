class Movie {
  String title;
  String posterUrl;

  Movie(this.title, this.posterUrl) {
    if(this.posterUrl != null) this.posterUrl = "https://image.tmdb.org/t/p/w342" + this.posterUrl;
    //Placeholder => should be cached offline => temporary
    else this.posterUrl = "https://www.vuecinemas.nl/thumb?w=268&f=jpg&src=userfiles/file/KLER_Poster_World.jpg&alt=img/movie_placeholder.png";
  }
}