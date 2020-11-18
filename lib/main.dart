import 'package:flutter/material.dart';
import 'package:gendotest/screens/home_screen.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
          fontFamily: "OpenSans",
      ),
      home: HomeScreen(),
    );
  }
}

