import 'package:blogapptrial/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: ob.currentTheme,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Image.asset('assets/accountImage.png'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 3)),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                ob.fullName,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: ob.currentTextTheme,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                ob.email,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: ob.currentTextTheme,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                ob.password,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: ob.currentTextTheme,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'version ' + ob.version,
              ),
              SizedBox(
                height: 30,
              ),
            ],
          )
        ],
      ),
    );
  }
}
