import 'package:blogapptrial/createPage/createPage.dart';
import 'package:blogapptrial/custWidgets/customWidgets.dart';
//import 'package:blogapptrial/dashboard/article.dart';
import 'package:blogapptrial/dummyPage.dart';
import 'package:blogapptrial/firestoreManagement/FirestoreUtility.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

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
                        onPressed: () async {
                          firestoreUtility.setDoc(ob.email);
                          await firestoreUtility.addDataArray(
                              'my-liked-authors', 'ami');
                          firestoreUtility.getDataArray('my-liked-authors');
                          setState(() {});
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
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width - 85,
              color: Colors.white,
              child: _divSelected == 0
                  ? HomeTab()
                  : _divSelected == 1
                      ? BookmarkTab()
                      : Container(),
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

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  //var _category = 'Misc';
  List<String> categories = [
    'All',
    'Science',
    'Technology',
    'Misc',
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> categoryChips = [];
    categories.forEach((element) {
      categoryChips.add(
        GestureDetector(
          child: Container(
            width: 120,
            child: Chip(
              backgroundColor:
                  ob.categoryForHome == element ? Colors.green : Colors.black45,
              label: Container(
                width: 70,
                height: 30,
                child: Center(
                  child: Text(element),
                ),
              ),
            ),
          ),
          onTap: () {
            setState(() {
              ob.categoryForHome = element;
            });
          },
        ),
      );
    });

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: ob.categoryForHome == 'All'
          ? Colors.amber
          : ob.categoryForHome == 'Science'
              ? Colors.cyanAccent
              : ob.categoryForHome == 'Technology'
                  ? Colors.indigo
                  : ob.categoryForHome == 'Misc'
                      ? Colors.purple
                      : Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfo(),
          SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Flexible(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: categoryChips,
                    ),
                  ),
                ],
              )),
          ArticleView(),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}

class BookmarkTab extends StatefulWidget {
  @override
  _BookmarkTabState createState() => _BookmarkTabState();
}

class _BookmarkTabState extends State<BookmarkTab> {
  List<String> categories = [
    'All',
    'Science',
    'Technology',
    'Misc',
  ];
  @override
  Widget build(BuildContext context) {
    List<Widget> categoryChips = [];
    categories.forEach((element) {
      categoryChips.add(
        GestureDetector(
          child: Container(
            width: 120,
            child: Chip(
              backgroundColor:
                  ob.categoryForHome == element ? Colors.green : Colors.black45,
              label: Container(
                width: 70,
                height: 30,
                child: Center(
                  child: Text(element),
                ),
              ),
            ),
          ),
          onTap: () {
            setState(() {
              ob.categoryForHome = element;
            });
          },
        ),
      );
    });
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfo(),
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Flexible(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: categoryChips,
                  ),
                ),
              ],
            ),
          ),
          ArticleView(),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
