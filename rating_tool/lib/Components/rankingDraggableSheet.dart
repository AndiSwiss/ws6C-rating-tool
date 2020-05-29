import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_tool/Data_Classes/movie.dart';

class RankingDraggableWidget extends StatefulWidget {
  final Movie movie;
  RankingDraggableWidget(this.movie);

  @override
  _RankingDraggableWidgetState createState() => _RankingDraggableWidgetState();
}

class _RankingDraggableWidgetState extends State<RankingDraggableWidget> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.2,
      maxChildSize: 1.0,
      expand: true,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 24),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Color.fromRGBO(35, 35, 35, 1),
            ),
            child: Column(
              children: <Widget>[
                ImageIcon(
                  AssetImage("assets/rating.png"),
                  color: Color.fromRGBO(87, 58, 96, 1),
                  size: 40,
                  semanticLabel: "Rating",
                ),
                SizedBox(height: 30),
                Text("Abstractness", style: TextStyle(color: Colors.white)),
                Slider(
                  onChanged: (double value) {
                    setState(() => widget.movie.abstractness = value);
                  },
                  value: widget.movie.abstractness,
                  max: 100,
                  min: 0,
                  inactiveColor: Colors.white10,
                  activeColor: Color.fromRGBO(200, 200, 200, 1),
                ),
                Text("Cinematography", style: TextStyle(color: Colors.white)),
                Slider(
                  onChanged: (double value) {
                    setState(() => widget.movie.cinematography = value);
                  },
                  value: widget.movie.cinematography,
                  max: 100,
                  min: 0,
                  inactiveColor: Colors.white10,
                  activeColor: Color.fromRGBO(200, 200, 200, 1),
                ),
                Text("Complexity", style: TextStyle(color: Colors.white)),
                Slider(
                  onChanged: (double value) {
                    setState(() => widget.movie.complexity = value);
                  },
                  value: widget.movie.complexity,
                  max: 100,
                  min: 0,
                  inactiveColor: Colors.white10,
                  activeColor: Color.fromRGBO(200, 200, 200, 1),
                ),
                Text("Darkness", style: TextStyle(color: Colors.white)),
                Slider(
                  onChanged: (double value) {
                    setState(() => widget.movie.darkness = value);
                  },
                  value: widget.movie.darkness,
                  max: 100,
                  min: 0,
                  inactiveColor: Colors.white10,
                  activeColor: Color.fromRGBO(200, 200, 200, 1),
                ),
                Text("Humor", style: TextStyle(color: Colors.white)),
                Slider(
                  onChanged: (double value) {
                    setState(() => widget.movie.humor = value);
                  },
                  value: widget.movie.humor,
                  max: 100,
                  min: 0,
                  inactiveColor: Colors.white10,
                  activeColor: Color.fromRGBO(200, 200, 200, 1),
                ),
                Text("Realism", style: TextStyle(color: Colors.white)),
                Slider(
                  onChanged: (double value) {
                    setState(() => widget.movie.realism = value);
                  },
                  value: widget.movie.realism,
                  max: 100,
                  min: 0,
                  inactiveColor: Colors.white10,
                  activeColor: Color.fromRGBO(200, 200, 200, 1),
                ),
                Text("Suspense", style: TextStyle(color: Colors.white)),
                Slider(
                  onChanged: (double value) {
                    setState(() => widget.movie.suspense = value);
                  },
                  value: widget.movie.suspense,
                  max: 100,
                  min: 0,
                  inactiveColor: Colors.white10,
                  activeColor: Color.fromRGBO(200, 200, 200, 1),
                ),
                Text("Wokeness", style: TextStyle(color: Colors.white)),
                Slider(
                  onChanged: (double value) {
                    setState(() => widget.movie.wokeness = value);
                  },
                  value: widget.movie.wokeness,
                  max: 100,
                  min: 0,
                  inactiveColor: Colors.white10,
                  activeColor: Color.fromRGBO(200, 200, 200, 1),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
