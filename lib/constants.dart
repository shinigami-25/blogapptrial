import 'package:blogapptrial/custWidgets/customWidgets.dart';
import 'package:flutter/material.dart';

class Constants {
  Color lightTheme = Colors.white70;
  Color darkTheme = Color.fromRGBO(2, 10, 73, 1);

  Color textLight = Colors.black54;
  Color textDark = Colors.white70;

  Color currentTheme;
  Color currentTextTheme;
  String name = 'Dummy Name', email = 'Dummy_email@dummy.com', password='dummypass';

  String version = '0.1';

  Constants() {
    this.currentTheme = lightTheme;
    this.currentTextTheme = textLight;
  }

  void setTheme(Color color) {
    this.currentTheme = color;
  }

  void setName(String name) {
    this.name = name;
  }

  void setPassword(String password) {
    this.password = password;
  }

  void setEmail(String email) {
    this.email = email;
  }
}

class DummyData {
  List<Widget> articles = [
    Article(),
    Article(),
    Article(),
  ];
}

var ob = Constants();

var ob2 = DummyData();