import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=60df7606";

void main() async{

  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white
    ), //ThemeData
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
  
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;

  void _realChanged(String text){
    print(text);
  }

  void _dolarChanged(String text){
    print(text);
  }

  void _euroChanged(String text){
    print(text);
  }

  @overrride
  Widget build(BuildContext context) {
    return Scaffold(
      backgroudColor: Colors.blue,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroudColor: Colors.silver,
        centerTitle: true,
      ), //AppBar
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text("Carregando Dados...",
                  style: TextStyle(
                    color: Colors.silver
                    fontSize: 25.0
                    ), //TextStyle
                textAlign: TextAlign.center,
                ) //Text
              ); //Center
            default:
              if(snapshot.hasError){
                return Center(
                  child: Text("Erro no download dos Dados...",
                    style: TextStyle(
                      color: Colors.silver
                      fontSize: 25.0
                    ), //TextStyle
                  textAlign: TextAlign.center,
                  ) //Text
                ); // Center
              } // if
              else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on, size: 150.0, color: Colors.silver),
                      buildTextField("Reais", "R\$", realController, _realChanged),
                      Divider(),                      
                      buildTextField("Dolares", "US\$", dolarController, _dolarChanged),
                      Divider(),
                      buildTextField("Euros", "EU\$", euroController, _euroChanged),
                    ], //Widget
                  ), //Column
                ); //SingleChildScrollView
              } //else
          } //switch
        }), //FutureBuilder
    ); //Scaffold
  }
}

Widget buildTextField(String label, String prefix, TextEditingController x, Function y){
  return TextField(
    controller: x,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.silve),
      border: OutLineInputBorder(),
      prefixText: prefix,
    ),//InputDecoration
    style: TextStyle(
      color: Colors.silver, fontSize: 25.0
    ), //TextStyle
    onChanged: f,
    keyboardType: TextInputType.number,
  ); //TextField
}
