class Movie {
  String title;
  String posterUrl;

  Movie(this.title, this.posterUrl) {
    this.posterUrl = "https://image.tmdb.org/t/p/w342" + this.posterUrl;
  }
}