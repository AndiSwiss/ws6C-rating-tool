import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_tool/Data_Classes/movie.dart';

class FavoriteIconButton extends StatefulWidget {
  const FavoriteIconButton({
    Key key,
    @required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  _FavoriteIconButtonState createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.movie.favorite ? Icons.favorite : Icons.favorite_border,
        color: Color.fromRGBO(253, 104, 104, 1),
        size: 40,
      ),
      onPressed: () {
        setState(() {
          widget.movie.favorite = !widget.movie.favorite;
        });
      },
    );
  }
}
