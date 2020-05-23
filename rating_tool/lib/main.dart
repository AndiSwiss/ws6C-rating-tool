import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rating_tool/Components/movieDetails.dart';
import 'package:rating_tool/Components/searchBar.dart';
import 'package:rating_tool/Views/FavoritesView.dart';
import 'package:rating_tool/Views/RatingsView.dart';
import 'package:rating_tool/Views/SearchView.dart';

import 'Components/moviePoster.dart';
import 'Data_Classes/movie.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

//declare theme colors
  static const MaterialColor customColor = MaterialColor(
    0xFF573A60,
    <int, Color>{
      50: Color.fromRGBO(87, 58, 96, .1),
      100: Color.fromRGBO(87, 58, 96, .2),
      200: Color.fromRGBO(87, 58, 96, .3),
      300: Color.fromRGBO(87, 58, 96, .4),
      400: Color.fromRGBO(87, 58, 96, .5),
      500: Color.fromRGBO(87, 58, 96, .6),
      600: Color.fromRGBO(87, 58, 96, .7),
      700: Color.fromRGBO(87, 58, 96, .8),
      800: Color.fromRGBO(87, 58, 96, .9),
      900: Color.fromRGBO(87, 58, 96, 1),
    },
  );


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Rating Tool',
      theme: ThemeData(
        primarySwatch: customColor,
        primaryColor: customColor,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => MyHomePage(
              title: "Movie Rating Tool",
            ),
        "/details": (context) => MovieDetails(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //set searchView to default page
  int bottomSelectedIndex = 1;


  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  PageController pageController = PageController(
    initialPage: 1, //searchView as default page
    keepPage: true,
  );

  void pageChanged(int index){
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(index){
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index, duration: Duration(microseconds: 500), curve: Curves.ease);
    });
  }

  Widget buildPageView(){
    return PageView(
      controller: pageController,
      onPageChanged: (index){
        pageChanged(index);
      },
      children: <Widget>[
        RatingsView(),
        SearchView(),
        FavoritesView(),
      ],
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: GoogleFonts.rubik(
            textStyle: TextStyle(color: Color.fromRGBO(249, 245, 227, 1), fontSize: 22, letterSpacing: 1, fontWeight: FontWeight.w400 )
        )),
        backgroundColor: Color.fromRGBO(42, 42, 42, 1),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            title: Text("Rating"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text("Favorites"),
          ),
        ],
        currentIndex: bottomSelectedIndex,
        selectedItemColor: Color.fromRGBO(149, 101, 164, 1),
        selectedIconTheme: IconThemeData(size: 33),
        iconSize: 24,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        onTap: (index){
          bottomTapped(index);
        },
        backgroundColor: Color.fromRGBO(42, 42, 42, 1),
      ),
    );
  }
}
