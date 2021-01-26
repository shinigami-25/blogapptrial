import 'package:blogapptrial/dashboard/dashBoard.dart';
import 'package:blogapptrial/firestoreManagement/Utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Google'),
          onPressed: () async {
            UserCredential cred = await authUtility.signInWithGoogle();
            if (cred.user != null) {
              ob.setEmail(cred.user.email);
              ob.setName(cred.user.displayName);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashBoard()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
