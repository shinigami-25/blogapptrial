import 'package:blogapptrial/custWidgets/customWidgets.dart';
import 'package:flutter/material.dart';

class DummyPage extends StatefulWidget {
  @override
  _DummyPageState createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        addAutomaticKeepAlives: true,
        scrollDirection: Axis.horizontal,
        children: [
        ],
      ),
    );
  }
}