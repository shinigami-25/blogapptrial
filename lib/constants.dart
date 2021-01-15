import 'package:blogapptrial/custWidgets/customWidgets.dart';
import 'package:flutter/material.dart';

class Constants {
  Color lightTheme = Colors.white70;
  Color darkTheme = Color.fromRGBO(2, 10, 73, 1);

  Color textLight = Colors.black54;
  Color textDark = Colors.white70;

  Color currentTheme;
  Color currentTextTheme;

  String currentDate = DateTime.now().toString().split(' ')[0];

  String fullName = 'Dummy Name', email = 'Dummy_email@dummy.com', password='dummypass';
  String name = 'Dummy', surname = 'Name';

  String version = '0.1';

  Constants() {
    this.currentTheme = lightTheme;
    this.currentTextTheme = textLight;
  }

  void setTheme(Color color) {
    this.currentTheme = color;
  }

  void setName(String name) {
    this.fullName = name;
    this.name = this.fullName.split(' ')[0];
    this.surname = this.fullName.split(' ')[this.fullName.split(' ').length - 1];
  }

  void setPassword(String password) {
    this.password = password;
  }

  void setEmail(String email) {
    this.email = email;
  }
}

class DummyData {
  var categorySelected = 0;

  List<Widget> articles = [
    ArticleTile(),
    ArticleTile(),
    ArticleTile(),
  ];

  List<Widget> categoryChips = [];
  List<String> categories = [
    'All',
    'Science',
    'Business',
    'Design',
  ];
}

var ob = Constants();

var ob2 = DummyData();