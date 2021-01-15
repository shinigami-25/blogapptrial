import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: ob.currentTheme,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,
                color: ob.currentTheme,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Image.asset('assets/create_vector.jpg'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 100.0,
                      spreadRadius: 0.1,
                      offset: Offset.fromDirection(8, 50)
                    ),
                  ]
                ),
              ),
              Text(
                'Create stories',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 25, 15, 5),
                child: Text(
                  'Describe your best life experiences with advanced editor',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
