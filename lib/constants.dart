import 'package:flutter/material.dart';

class Constants {
  Color lightTheme = Colors.white70;
  Color darkTheme = Color.fromRGBO(2, 10, 73, 1);
  Color currentTheme;

  void setTheme(Color color) {
    currentTheme = color;
  }
}

var ob = Constants();