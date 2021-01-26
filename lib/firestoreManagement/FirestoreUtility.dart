import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthUtility {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class StorageUtility {
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference _ref;

  Future<List<String>> files(var category) async {
    _ref = storage.ref('All');
    List<String> allFiles = [];
    ListResult files = await _ref.listAll();
    files.items.forEach((element) {
      if (element.name.toString().split(';')[0] == category) {
        allFiles.add(element.fullPath);
      } else if (category == 'All') {
        allFiles.add(element.fullPath);
      }
    });
    return allFiles;
  }
}

class FirestoreUtility {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentReference _ref;
  String user;

  Future<bool> checkDoc(var param) async {
    bool flag = false;
    _ref = firestore.collection('users').doc(param);
    DocumentSnapshot snapshot = await _ref.get();
    if (snapshot != null && snapshot.exists) {
      flag = true;
    }
    return flag;
  }

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

  Future<void> addToDataArray(var field, var data) async {
    List prevData = await _ref.get().then((value) => value.get(field));
    if (!prevData.contains(data)) prevData.add(data);
    await _ref.update({
      field: prevData,
    });
  }

  Future<void> removeFromDataArray(var field, var data) async {
    List prevData = await _ref.get().then((value) => value.get(field));
    if (prevData.contains(data)) prevData.remove(data);
    await _ref.update({
      field: prevData,
    });
  }

  Future<dynamic> getDataArray(var field) async {
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
var storageUtility = StorageUtility();
var authUtility = AuthUtility();
