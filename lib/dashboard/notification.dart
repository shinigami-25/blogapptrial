import 'package:blogapptrial/dashboard/article.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blogapptrial/firestoreManagement/Utility.dart';

class NotificationTile extends StatefulWidget {
  NotificationTile(this.filename);
  final String filename;
  @override
  _NotificationTileState createState() => _NotificationTileState(filename);
}

class _NotificationTileState extends State<NotificationTile> {
  _NotificationTileState(this.filename);

  String category() {
    return this.filename.split('/')[1].split(';')[0];
  }

  String title() {
    return this.filename.split('/')[1].split(';')[1];
  }

  String author() {
    return this.filename.split('/')[1].split(';')[2].split('.')[0];
  }

  final String filename;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      child: GestureDetector(
        child: Padding(
          padding: EdgeInsets.fromLTRB(3, 10, 3, 0),
          child: Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(),
            child: Material(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title().length < 25
                          ? title()
                          : title().substring(0, 22) + '...',
                      style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      author().length < 38
                          ? author()
                          : author().substring(0, 35) + '...',
                      style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      category().length < 38
                          ? category()
                          : category().substring(0, 35) + '...',
                      style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              elevation: 15,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
        ),
        onTap: () async {
          while (Navigator.canPop(context)) Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ArticlePage(this.filename)));
          
          await firestoreUtility.removeFromDataArray(
              'notification', this.filename);
        },
      ),
      onDismissed: (dir) async {
        await firestoreUtility.removeFromDataArray(
            'notification', this.filename);
      },
    );
  }
}

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FutureBuilder(
        future: firestoreUtility.getDataArray('notification'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data != []) {
              List<Widget> notifs = [];
              snapshot.data.forEach((value) {
                notifs.add(NotificationTile(value));
              });
              return ListView(
                children: notifs,
              );
            }
            if (snapshot.hasData && snapshot.data == []) {
              return Text(
                'No pending notifications',
                style: GoogleFonts.ubuntu(),
              );
            }
          }

          if (snapshot.hasData && snapshot.data == null) {
            return Text(
              'No pending notifications',
              style: GoogleFonts.ubuntu(),
            );
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
