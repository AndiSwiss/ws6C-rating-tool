
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingsView extends StatefulWidget{
  final String title;
  RatingsView({this.title = "Favorites"});

  @override
  _RatingsViewState createState() => _RatingsViewState();
}

class _RatingsViewState extends State<RatingsView>{


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellowAccent,
      child: Text("Ratings Page"),
    );
  }

}