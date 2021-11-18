import 'package:cloud_firestone/cloud_firestone.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());

  Firestone.instance.collection("col").document("doc").setData({"texto": "marcelo"});

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "chatnet",
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ), // ThemeData
      home: Container(),
    ); // MaterialApp
  } // Widget build
} // MyApp