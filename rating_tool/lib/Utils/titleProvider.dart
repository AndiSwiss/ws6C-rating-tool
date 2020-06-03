import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleProvider extends ChangeNotifier {
  String title = "Movie Rating Tool";

  void setTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
  }
}
