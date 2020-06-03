import 'package:flutter/cupertino.dart';
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
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 6,
            offset: Offset(0.0, 0.35),
          ),
        ],
        color: Color.fromRGBO(42, 42, 42, 1),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 4, 20, 16),
        child: TextField(
          controller: _controller,
          onChanged: null,
          onSubmitted: widget.onSubmit,
          autocorrect: false,
          style: TextStyle(color: Colors.black, fontSize: 15),
          maxLines: 1,
          expands: false,
          decoration: InputDecoration(
            contentPadding: new EdgeInsets.all(0),
            hintText: "Search for a movie...",
            prefixIcon: Icon(Icons.search, color: Colors.black87, size: 23),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(width: 0.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 0.0,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            filled: true,
            fillColor: Color.fromRGBO(240, 240, 240, 1),
          ),
        ),
      ),
    );
  }
}
