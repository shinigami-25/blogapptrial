import 'package:blogapptrial/createPage/createPage.dart';
import 'package:blogapptrial/custWidgets/customWidgets.dart';
import 'package:blogapptrial/dashboard/article.dart';
import 'package:blogapptrial/dummyPage.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var _divSelected = 0;
  DateTime today = DateTime.now();
  var articleView;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 80,
              child: Material(
                color: Colors.black26,
                elevation: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.transparent,
                      child: IconButton(
                        icon: Icon(Icons.logout),
                        color: Colors.black,
                        iconSize: 40,
                        onPressed: () {
                          setState(() {
                            
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color:
                          _divSelected == 0 ? Colors.white : Colors.transparent,
                      child: IconButton(
                        icon: Icon(
                          Icons.home_outlined,
                          color: Colors.black,
                          size: 40,
                        ),
                        onPressed: () {
                          setState(() {
                            _divSelected = 0;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color:
                          _divSelected == 1 ? Colors.white : Colors.transparent,
                      child: IconButton(
                        icon: Icon(
                          Icons.bookmark_border_outlined,
                          color: Colors.black,
                          size: 40,
                        ),
                        onPressed: () {
                          setState(() {
                            _divSelected = 1;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color:
                          _divSelected == 2 ? Colors.white : Colors.transparent,
                      child: IconButton(
                        icon: Icon(
                          Icons.notifications_none_outlined,
                          color: Colors.black,
                          size: 40,
                        ),
                        onPressed: () {
                          setState(() {
                            _divSelected = 2;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color:
                          _divSelected == 3 ? Colors.white : Colors.transparent,
                      child: IconButton(
                        icon: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.black,
                          size: 40,
                        ),
                        onPressed: () {
                          setState(() {
                            _divSelected = 3;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color:
                          _divSelected == 4 ? Colors.white : Colors.transparent,
                      child: IconButton(
                        icon: Icon(
                          Icons.settings_outlined,
                          color: Colors.black,
                          size: 40,
                        ),
                        onPressed: () {
                          setState(() {
                            _divSelected = 4;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width - 85,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: _divSelected == 0
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            UserInfo(),
                            ArticleView('Misc'),
                            SizedBox(height: 150),
                          ],
                        ),
                      )
                    : _divSelected == 1
                        ? ArticleView('Science')
                        : DummyPage(),
              ),
            ),
          ],
        ),
        floatingActionButton: _divSelected == 0
            ? FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreatePage1()));
                },
              )
            : Container(),
      ),
    );
  }
}
