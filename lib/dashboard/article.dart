import 'package:blogapptrial/constants.dart';
import 'package:blogapptrial/firestoreManagement/FirestoreUtility.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ArticleTile extends StatefulWidget {
  final filename;
  ArticleTile(this.filename);

  @override
  _ArticleTileState createState() => _ArticleTileState(this.filename);
}

class _ArticleTileState extends State<ArticleTile> {
  final filename;
  _ArticleTileState(this.filename);
  bool _faved = false, _favedButton = false;
  String filePath() {
    return this.filename.split(':')[2].split(')')[0];
  }

  // example filePath : Reference(app: [DEFAULT], fullPath: All/Science;First Article;Dummy_email.txt)

  String title() {
    return filePath().split(';')[1];
  }

  String category() {
    return filePath().split(';')[0].split('/')[1];
  }

  String author() {
    return filePath().split(';')[2].split('.')[0];
  }

  @override
  Widget build(BuildContext context) {
    var temp = category() + ';' + title() + ';' + author() + '.txt';

    return FutureBuilder(
      future: firestoreUtility.getDataArray('my-liked-articles'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.contains(temp)) {
            _faved = true;
          } else {
            _faved = false;
          }
          return GestureDetector(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 2, 5, 2),
              child: Material(
                elevation: 25,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                child: Container(
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Image.asset('assets/accountImage.png'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 149,
                            ),
                            Container(
                              height: 150,
                              width: 200,
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    softWrap: true,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: title() + '\n',
                                          style: GoogleFonts.ubuntu(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: author() + '\n',
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.brown,
                                          ),
                                        ),
                                        TextSpan(
                                          text: category(),
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                            height: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(!_favedButton
                            ? Icons.favorite_border_outlined
                            : Icons.favorite,
                            size: 35,
                            color: Colors.red,
                        ),
                        onPressed: () async {
                          _faved
                              ? await firestoreUtility
                                  .removeFromDataArray(
                                      'my-liked-articles', temp)
                              : await firestoreUtility
                                  .addToDataArray(
                                      'my-liked-articles', temp);
                          _faved
                              ? await firestoreUtility
                                  .removeFromDataArray(
                                      'my-liked-authors', temp)
                              : await firestoreUtility
                                  .addToDataArray(
                                      'my-liked-authors', temp);
                          setState(() {
                            _faved = !_faved;
                            _favedButton = !_favedButton;
                          });
                        },
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            onTap: () {
              print(title());
              print(category());
              print(author());
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ArticlePage(temp)));
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ArticleViewHomeTab extends StatefulWidget {
  @override
  _ArticleViewHomeTabState createState() => _ArticleViewHomeTabState();
}

class _ArticleViewHomeTabState extends State<ArticleViewHomeTab> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ob.current,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<ArticleTile> articles = [];
          snapshot.data.items.forEach((element) {
            if (!articles.contains(ArticleTile(element.toString()))) {
              articles.add(ArticleTile(element.toString()));
            }
          });
          return Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: articles,
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
              backgroundColor: Colors.white,
            ),
          );
        }

        if (snapshot.hasError) {
          Container(
            height: 500,
            width: 500,
            color: Colors.red,
          );
        }

        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 5,
            backgroundColor: Colors.white,
          ),
        );
      },
    );
  }
}

class ArticlePage extends StatefulWidget {
  ArticlePage(this.title);
  final String title;
  @override
  _ArticlePageState createState() => _ArticlePageState(this.title);
}

class _ArticlePageState extends State<ArticlePage> {
  _ArticlePageState(this.title) {
    print('->' + this.title.toString());
    ref = storage.ref('All').child(this.title);
  }
  final title;
  final storage = FirebaseStorage.instance;
  Reference ref;

  String content = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: ref.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            snapshot.data.forEach((element) {
              content += String.fromCharCode(element);
            });
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(content),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Container(
                height: 200,
                width: 200,
                color: Colors.red,
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 15,
              backgroundColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
