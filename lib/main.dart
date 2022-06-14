import 'package:flutter/material.dart';
import 'package:note_beer/screens/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beear Note',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home:  DashBoard(),
    );
  }
}