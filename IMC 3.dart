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
            onPressed: () {},
          ), //IconButton
        ], //<Widget>[]
      ), //AppBar
      backgroudColor: Colors.white,
      body: SingChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(Icons.person_outline, size: 120.0, color: Colors.green),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Peso em (Kg)",
                labelStyle: TextStyle(color: Colors.green)
              ), //InputDecoration
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25.0),
            ), // TextField
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Altura em (cm)",
                labelStyle: TextStyle(color: Colors.green)
              ), //InputDecoration
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25.0),
            ), // TextField
            Padding(
              padding: EdgeInsets.only(top: 10.0, botton: 10.0),
              child: Container(
                height: 50.0,
                child: RaiseButton(
                  onPressed: (){},
                  child: Text("Calcular",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),), //Text
                  color: Colors.green,
                ), //RaiseButton
              ), // Container
            ), // Padding
            Text("Info",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.greeen, fontSize: 25.0),
            ), // Text
          ], //<Widget>[]
        ), //Column
      ), //SingChildScrollView
    ); //Scaffold
  }
}
