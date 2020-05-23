
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritesView extends StatefulWidget{
  final String title;
  FavoritesView({this.title = "Favorites"});

  @override
  _FavoritesViewState createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView>{


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      child: Text("Favorites Page"),
    );
  }

}