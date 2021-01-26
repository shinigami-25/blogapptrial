import 'package:blogapptrial/accountPage/profilePage.dart';
import 'package:blogapptrial/createPage/createPage.dart';
import 'package:blogapptrial/custWidgets/customWidgets.dart';
import 'package:blogapptrial/firestoreManagement/Utility.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'article.dart';
import 'notification.dart';
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
    Future<bool> flag = firestoreUtility.checkDoc(ob.email);
    return FutureBuilder(
        future: flag,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              print(true);
              firestoreUtility.setDoc(ob.email);
            } else {
              print(false);
              firestoreUtility.addDoc(ob.email);
            }
          }
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
                              icon: Icon(Icons.book),
                              color: Colors.black,
                              iconSize: 40,
                              onPressed: () {
                                setState(() {});
                              },
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            color: _divSelected == 0
                                ? Colors.white
                                : Colors.transparent,
                            child: IconButton(
                              icon: Icon(
                                _divSelected == 0
                                    ? Icons.home
                                    : Icons.home_outlined,
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
                            color: _divSelected == 1
                                ? Colors.white
                                : Colors.transparent,
                            child: IconButton(
                              icon: Icon(
                                _divSelected == 1
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
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
                            color: _divSelected == 2
                                ? Colors.white
                                : Colors.transparent,
                            child: IconButton(
                              icon: Icon(
                                _divSelected == 2
                                    ? Icons.notifications
                                    : Icons.notifications_none_outlined,
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
                            color: _divSelected == 3
                                ? Colors.white
                                : Colors.transparent,
                            child: IconButton(
                              icon: Icon(
                                _divSelected == 3
                                    ? Icons.account_circle
                                    : Icons.account_circle_outlined,
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
                            color: _divSelected == 4
                                ? Colors.white
                                : Colors.transparent,
                            child: IconButton(
                              icon: Icon(
                                _divSelected == 4
                                    ? Icons.settings
                                    : Icons.settings_outlined,
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
                            ? FavedTab()
                            : _divSelected == 2
                                ? NotificationTab()
                                : _divSelected == 3
                                    ? ProfilePage()
                                    : Container(),
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.ac_unit_outlined,
                      size: 0,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.ac_unit_outlined,
                      size: 0,
                    ),
                    label: '',
                  ),
                ],
              ),
              floatingActionButton: _divSelected == 0
                  ? FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreatePage1()));
                      },
                    )
                  : Container(),
            ),
          );
        });
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
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          UserInfo(),
          SizedBox(
              height: 100,
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
          SizedBox(
            height: 320,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ArticleViewHome(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FavedTab extends StatefulWidget {
  @override
  _FavedTabState createState() => _FavedTabState();
}

class _FavedTabState extends State<FavedTab> {
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfo(),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
            child: Text(
              'My favs',
              style: GoogleFonts.ubuntu(
                fontSize: 36,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 150,
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
          SizedBox(
            height: 320,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ArticleViewFav(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationTab extends StatefulWidget {
  @override
  _NotificationTabState createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          NotificationView(),
        ],
      ),
    );
  }
}
