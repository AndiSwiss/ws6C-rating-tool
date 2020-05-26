import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_tool/Utils/FadeRoute.dart';
import 'package:rating_tool/main.dart';

class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  @override
  void initState(){
    super.initState();
    Timer(Duration(milliseconds: 2500), () => Navigator.pushAndRemoveUntil(context, FadeRoute(page: MyHomePage()), ModalRoute.withName("/search")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/SS_gradient.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Image.asset(
            "assets/animated_app_icon.gif",
            height: 165,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

}