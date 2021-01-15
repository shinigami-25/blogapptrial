import 'package:flutter/material.dart';

import '../constants.dart';
class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.black54,
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz_outlined),
            color: Colors.black54,
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                cacheExtent: 100,
                itemBuilder: (context, index) {
                  return ob2.articles[index];
                },
                itemCount: ob2.articles.length,
                scrollDirection: Axis.horizontal,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        iconSize: 30,
        selectedIconTheme: IconThemeData(
          color: Colors.black87,
        ),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selected,
        type: BottomNavigationBarType.fixed,
        onTap: (val) {
          setState(() {
            _selected = val;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'home',
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'bookmark',
            icon: Icon(
              Icons.bookmark_border_outlined,
              color: Colors.black,
            ),
            activeIcon: Icon(Icons.bookmark),
          ),
          BottomNavigationBarItem(
              label: 'notification',
              icon: Icon(
                Icons.notifications_none_outlined,
                color: Colors.black,
              ),
              activeIcon: Icon(Icons.notifications)
          ),
          BottomNavigationBarItem(
              label: 'profile',
              icon: Icon(
                Icons.account_circle_outlined,
                color: Colors.black,
              ),
              activeIcon: Icon(Icons.account_circle)
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.black87,
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
