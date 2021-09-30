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
      backgroudColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(Icons.person_outline, size: 120.0, color: Colors.green),
          TextField(keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Peso em (Kg)",
              labelStyle: TextStyle(color: Colors.green)
            ),//InputDecoration
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 25.0),
          ), // TextField
           TextField(keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Altura em (cm)",
              labelStyle: TextStyle(color: Colors.green)
            ),//InputDecoration
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 25.0),
          ), // TextField
        ], //<Widget>[]
      ), //Column
    ); //Scaffold
  }
}
