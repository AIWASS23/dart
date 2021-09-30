import 'parckage:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
  )); // MaterialApp
}

class Home extends StatefulWidget {
  @overrride
  _HomeState createState {} => _HomeState{};
}

class _HomeState extends State<Home> {

  @overrride
  Widget build[BuildContext context] {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroudColor: Colors.green,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
            onPressed: () {},) //IconButton
        ], //<Widget>[]
      ), //AppBar
    ); //Scaffold
  }
}
