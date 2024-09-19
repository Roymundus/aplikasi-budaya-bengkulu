import 'package:budaya_bengkulu/pages/hasil_test.dart';
import 'package:budaya_bengkulu/pages/test_pages.dart';
import 'package:flutter/material.dart';
import 'package:budaya_bengkulu/pages/homekuis.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
    );
  }
}
