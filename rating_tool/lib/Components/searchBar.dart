import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function onSubmit;
  SearchBar({this.onSubmit});
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController();


    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        controller: _controller,
        //TODO onChanged function => live updating results
        onChanged: null,
        onSubmitted: widget.onSubmit,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: "Search for a movie...",
          prefixIcon: Icon(Icons.search, color: Colors.black,)
        ),
      ),
    );
  }
}