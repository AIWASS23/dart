import 'package:cloud_firestone/cloud_firestone.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());

  Firestone.instance.collection("mensagens").document("mensagem1").setData({
    'texto': 'Oi tudo bem?',
    'from': 'marcelo',
    'read': false,
  }); // setData
  
  Firestone.instance.collection("mensagens").document("mensagem1").updateData({
    'texto': 'Oi tudo bem?',
    'from': 'marcelo',
    'read': true,
  }); // updateData


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