import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class ArticleTile extends StatefulWidget {
  final title;
  final category;
  ArticleTile(this.title, this.category);

  @override
  _ArticleTileState createState() =>
      _ArticleTileState(this.title, this.category);
}

class _ArticleTileState extends State<ArticleTile> {
  final title;
  final category;
  _ArticleTileState(this.title, this.category);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.fromLTRB(25, 50, 0, 50),
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width / 2,
          // padding: EdgeInsets.fromLTRB(2, 2, 2, 5),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    text: TextSpan(
                      text: this.title.split('.')[0],
                      style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.0, 25.0),
                blurRadius: 25,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticlePage(this.title)));
      },
    );
  }
}

class ArticleView extends StatefulWidget {
  ArticleView(this.category);
  final category;
  @override
  _ArticleViewState createState() => _ArticleViewState(ob.categoryForHome);
}

class _ArticleViewState extends State<ArticleView> {
  _ArticleViewState(this.category);
  final category;
  @override
  Widget build(BuildContext context) {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref('All').child(ob.categoryForHome);
    return FutureBuilder(
      future: ref.list(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<ArticleTile> articles = [];
          snapshot.data.items.forEach((element) {
            if (!articles
                .contains(ArticleTile(element.name.toString(), ob.categoryForHome)))
              articles.add(ArticleTile(element.name.toString(), ob.categoryForHome));
          });
          return Flexible(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: articles,
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 15,
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
            strokeWidth: 15,
            backgroundColor: Colors.white,
          ),
        );
      },
    );
  }
}

class ArticlePage extends StatefulWidget {
  ArticlePage(this.title);
  final title;
  @override
  _ArticlePageState createState() =>
      _ArticlePageState(this.title);
}

class _ArticlePageState extends State<ArticlePage> {
  _ArticlePageState(this.title) {
    ref = storage.ref('All').child(ob.categoryForHome).child(this.title);
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
