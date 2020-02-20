import 'package:flutter/material.dart';
import 'package:rating_tool/Data_Classes/movie.dart';

class MovieDetails extends StatefulWidget {
  String title;
  MovieDetails({this.title = "Movie Rating Tool"});

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  double valueSlider1 = 50;
  double valueSlider2 = 50;
  double valueSlider3 = 50;
  double valueSlider4 = 50;
  double valueSlider5 = 50;
  double valueSlider6 = 50;

  @override
  Widget build(BuildContext context) {
    Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                Container(
                  width: 342 / 2,
                  child: movie.poster,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              movie.title,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(movie.description, softWrap: true, maxLines: 5, overflow: TextOverflow.ellipsis,),
                            )
                          ]),
                    ),
                  ),
                )
              ]),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Container(
                    height: 275,
                    child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                        Text("Abstractness"),
                        Slider(
                          onChanged: (double value) {
                            setState(() => movie.abstractness = value);
                          },
                          value: movie.abstractness,
                          max: 100,
                          min: 0,
                        ),
                        Text("Cinematography"),
                        Slider(
                          onChanged: (double value) {
                            setState(() => movie.cinematography = value);
                          },
                          value: movie.cinematography,
                          max: 100,
                          min: 0,
                        ),
                        Text("Complexity"),
                        Slider(
                          onChanged: (double value) {
                            setState(() => movie.complexity = value);
                          },
                          value: movie.complexity,
                          max: 100,
                          min: 0,
                        ),
                        Text("Darkness"),
                        Slider(
                          onChanged: (double value) {
                            setState(() => movie.darkness = value);
                          },
                          value: movie.darkness,
                          max: 100,
                          min: 0,
                        ),
                        Text("Humor"),
                        Slider(
                          onChanged: (double value) {
                            setState(() => movie.humor = value);
                          },
                          value: movie.humor,
                          max: 100,
                          min: 0,
                        ),
                        Text("Realism"),
                        Slider(
                          onChanged: (double value) {
                            setState(() => movie.realism = value);
                          },
                          value: movie.realism,
                          max: 100,
                          min: 0,
                        ),
                        Text("Suspense"),
                        Slider(
                          onChanged: (double value) {
                            setState(() => movie.suspense = value);
                          },
                          value: movie.suspense,
                          max: 100,
                          min: 0,
                        ),
                        Text("Wokeness"),
                        Slider(
                          onChanged: (double value) {
                            setState(() => movie.wokeness = value);
                          },
                          value: movie.wokeness,
                          max: 100,
                          min: 0,
                        )
                      ]),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
