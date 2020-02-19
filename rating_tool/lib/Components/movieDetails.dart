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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            movie.title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text("INSERT DESCRIPTION"),
                          )
                        ]),
                  ),
                )
              ]),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Container(
                    height: 250,
                    child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                        Slider(
                          onChanged: (double value) {
                            setState(() => this.valueSlider1 = value);
                          },
                          
                          value: valueSlider1,
                          max: 100,
                          min: 0,
                        ),
                        Slider(
                          onChanged: (double value) {
                            setState(() => this.valueSlider2 = value);
                          },
                          value: valueSlider2,
                          max: 100,
                          min: 0,
                        ),
                        Slider(
                          onChanged: (double value) {
                            setState(() => this.valueSlider3 = value);
                          },
                          value: valueSlider3,
                          max: 100,
                          min: 0,
                        ),
                        Slider(
                          onChanged: (double value) {
                            setState(() => this.valueSlider4 = value);
                          },
                          value: valueSlider4,
                          max: 100,
                          min: 0,
                        ),
                        Slider(
                          onChanged: (double value) {
                            setState(() => this.valueSlider5 = value);
                          },
                          value: valueSlider5,
                          max: 100,
                          min: 0,
                        ),
                        Slider(
                          onChanged: (double value) {
                            setState(() => this.valueSlider6 = value);
                          },
                          value: valueSlider6,
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
