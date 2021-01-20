import 'package:blogapptrial/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dashboard/article.dart';

class ArticleView extends StatefulWidget {
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    FirebaseStorage storage = FirebaseStorage.instance;
    return FutureBuilder(
      future: storage.ref('All').list(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<ArticleTile> articles = [];
          snapshot.data.items.forEach((element) {
            String cate = element.name.toString().split(';')[0];
            String title = element.name.toString().split(';')[1];
            if (!articles.contains(ArticleTile(title, cate))) {
              if (cate == ob.categoryForHome)
                articles.add(ArticleTile(title, cate));
              else if (ob.categoryForHome == 'All')
                articles.add(ArticleTile(title, cate));
            }
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
