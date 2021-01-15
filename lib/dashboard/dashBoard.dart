import 'package:blogapptrial/custWidgets/customWidgets.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var navBarItemSelected = 0;
  var chipSelected = 0;

  List<Widget> chips = [];

  void populateChips() {
    chips = [];
    ob2.categories.forEach((element) {
      chips.add(GestureDetector(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: Chip(
            backgroundColor: this.chipSelected == ob2.categories.indexOf(element)? Colors.black54: Colors.white54,
            label: Container(
              width: 100,
              child: Text(
                element,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: this.chipSelected == ob2.categories.indexOf(element)? Colors.white: Colors.black54,
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            labelPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          ),
        ),
        onTap: () {
          setState(() {
            this.chipSelected = ob2.categories.indexOf(element);
          });
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    populateChips();

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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserInfo(),
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: this.chips.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return this.chips[index];
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                cacheExtent: 100,
                itemBuilder: (context, index) {
                  return ob2.articles[index];
                },
                itemCount: ob2.categories.length,
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
        currentIndex: navBarItemSelected,
        type: BottomNavigationBarType.fixed,
        onTap: (val) {
          setState(() {
            navBarItemSelected = val;
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
