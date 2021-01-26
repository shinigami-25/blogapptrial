import 'package:blogapptrial/constants.dart';
import 'package:blogapptrial/dashboard/dashBoard.dart';
import 'package:blogapptrial/firestoreManagement/Utility.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleTile extends StatefulWidget {
  final String filename;
  ArticleTile(this.filename);

  @override
  _ArticleTileState createState() => _ArticleTileState(this.filename);
}

class _ArticleTileState extends State<ArticleTile> {
  final String filename;
  _ArticleTileState(this.filename);
  bool _faved = false;
  String filePath() {
    return this.filename.split(':')[2].split(')')[0];
  }

  // example filePath : Reference(app: [DEFAULT], fullPath: All/Science;First Article;Dummy_email.txt)

  String category() {
    return filename.split(';')[0].split('/')[1];
  }

  String title() {
    return filename.split(';')[1];
  }

  String author() {
    return filename.split(';')[2].split('.')[0];
  }

  @override
  Widget build(BuildContext context) {
    var temp = filename;

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
                          color: Colors.black12,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
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
                        icon: Icon(
                          !_faved
                              ? Icons.favorite_border_outlined
                              : Icons.favorite,
                          size: 35,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          if (_faved) {
                            await firestoreUtility.removeFromDataArray(
                                'my-liked-articles', temp);
                            await firestoreUtility.removeFromDataArray(
                                'my-liked-authors', author());
                          } else {
                            await firestoreUtility.addToDataArray(
                                'my-liked-articles', temp);
                            await firestoreUtility.addToDataArray(
                                'my-liked-authors', author());
                            await firestoreUtility.addFollower(
                                author(), ob.email);
                          }
                          setState(() {
                            _faved = !_faved;
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

class ArticleViewHome extends StatefulWidget {
  @override
  _ArticleViewHomeState createState() => _ArticleViewHomeState();
}

class _ArticleViewHomeState extends State<ArticleViewHome> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storageUtility.files(ob.categoryForHome),
      builder: (context, snapshot) {
        List<ArticleTile> articles = [];
        if (snapshot.hasData) {
          snapshot.data.forEach((value) {
            if (!articles.contains(ArticleTile(value)))
              articles.add(ArticleTile(value));
          });
          return Flexible(
            child: ListView(
              children: articles,
              scrollDirection: Axis.horizontal,
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class ArticleViewFav extends StatefulWidget {
  @override
  _ArticleViewFavState createState() => _ArticleViewFavState();
}

class _ArticleViewFavState extends State<ArticleViewFav> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firestoreUtility.getDataArray('my-liked-articles'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Widget> articles = [];

        if (snapshot.data != null) {
          snapshot.data.forEach((value) {
            if (value.split('/')[1].split(';')[0] == ob.categoryForHome)
              articles.add(ArticleTile(value));
            else if (ob.categoryForHome == 'All')
              articles.add(ArticleTile(value));
          });

          return Flexible(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: articles,
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
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
    ref = storage.ref('All').child(this.title.split('/')[1]);
  }
  final title;
  final storage = FirebaseStorage.instance;
  Reference ref;
  bool _faved = false;

  String content = '';

  String author() {
    return title.split(';')[2].split('.')[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title.split('/')[1].split(';')[1]),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            while (Navigator.canPop(context)) Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => DashBoard()));
          },
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: ref.getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                snapshot.data.forEach((element) {
                  content += String.fromCharCode(element);
                });
                return Padding(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SelectableText(
                      content,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                  ),
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
          Positioned(
            right: 20,
            top: 20,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: IconButton(
                icon: Icon(
                  !_faved ? Icons.favorite_border_outlined : Icons.favorite,
                  size: 35,
                  color: Colors.red,
                ),
                onPressed: () async {
                  if (_faved) {
                    await firestoreUtility.removeFromDataArray(
                        'my-liked-articles', this.title);
                    await firestoreUtility.removeFromDataArray(
                        'my-liked-authors', author());
                  } else {
                    await firestoreUtility.addToDataArray(
                        'my-liked-articles', this.title);
                    await firestoreUtility.addToDataArray(
                        'my-liked-authors', author());
                    await firestoreUtility.addFollower(author(), ob.email);
                  }
                  setState(() {
                    _faved = !_faved;
                  });
                },
                color: Colors.blue,
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
