import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twitter_clone/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twitter Clone',
      theme: ThemeData(
        fontFamily: GoogleFonts.heebo().fontFamily,
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
      ),
      home: const HomePage(),
    );
  }
}
