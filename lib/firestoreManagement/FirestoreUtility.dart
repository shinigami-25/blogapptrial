import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUtility {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentReference _ref;
  String user;

  void addDoc(var param) {
    user = param;
    _ref = firestore.collection('users').doc(param);
    _ref.set({
      'my-blogs': [],
      'my-liked-articles': [],
      'my-liked-authors': [],
    });
  }

  void setDoc(var param) {
    user = param;
    _ref = firestore.collection('users').doc(param);
  }

  Future<void> addDataArray(var field, var data) async {
    var prevData = await _ref.get().then((value) => value.get(field));
    prevData.add(data);
    await _ref.update({
      field: prevData,
    });
  }

  dynamic getDataArray(var field) async {
    var snapshot = await _ref.get();
    var data = await snapshot.get(field);
    print(data);
    return data;
  }
}

class AdmobUtility {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6896925330712949~5213019803";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6896925330712949/4767626232";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4339318960";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
/*
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/7049598008";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/3964253750";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/8673189370";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/7552160883";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
*/
}

var firestoreUtility = FirestoreUtility();
