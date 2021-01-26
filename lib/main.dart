import 'package:blogapptrial/onboarding/login.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: 'ca-app-pub-6896925330712949/4767626232',
      size: AdSize.banner,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  await Firebase.initializeApp();
  FirebaseAdMob.instance
      .initialize(appId: 'ca-app-pub-6896925330712949~5213019803');
  createBannerAd()
    ..load()
    ..show();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            color: Colors.red,
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.indigo,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: LoginPage(),
          );
        }

        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.indigo,
            strokeWidth: 15,
          ),
        );
      },
    );
  }
}
