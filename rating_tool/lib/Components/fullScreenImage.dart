import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final url = ModalRoute.of(context).settings.arguments;
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: url!= null ? new Image.network(
          url,
          fit: BoxFit.contain,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ) : new Container(),
      ),
    );
  }
}
