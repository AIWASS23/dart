import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=60df7606";

void main() async{

  runApp(MaterialApp(
    home: Home(),
  )); // MaterialApp
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @overrride
  _HomeState createState () => _HomeState();
}

class _HomeState extends State<Home> {
  @overrride
  Widget build(BuildContext context) {
    return Scaffold(
      backgroudColor: Colors.blue,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroudColor: Colors.silver,
        centerTitle: true,
      ), //AppBar
    ); //Scaffold
  }
}