import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    titler: "contador de pessoas",
    home: Colurn(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Pessoas: 0",
          style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold),
        ), // Text
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text(
                "+1",
                style: TextStyle(fontSize: 40.0, color: Colors.white),
              ), //Text
              onPressed: () {}, 
            ), // FlatButton
            FlatButton(
              child: Text(
                "+1",
                style: TextStyle(fontSize: 40.0, color: Colors.white),
              ), //Text
              onPressed: () {}, 
            ), // FlatButton
          ], \\ Widget
        ), //Row
        Text(
          "Pode Entrar!",
          style: TextStyle(
              color: Colors.white,
              fontStyle:FontStyle.italic,
              fontSize: 30.0), //TextStyle
        ) // Text
      ], // <Widget>
    ))); // Colurn, MaterialApp

}; 