import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    titler: "contador de pessoas",
    home: Stack(
      children: <Widget>[
        Image.asset(
          "images/restaurant.jpg",
          fit: BoxFit.cover,
          height: 1000.0,
        ), // Image.asset
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
             "Pessoas: 0",
              style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold),
            ), // Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsert.all(10.0),
                  child: FlatButton(
                    child: Text(
                      "+1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ), //Text
                    onPressed: () {}, 
                  ), // FlatButton
                ), // Padding
                Padding(
                  padding: EdgeInsert.all(10.0),
                  child: FlatButton(
                    child: Text(
                      "-1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ), //Text
                    onPressed: () {}, 
                  ), // FlatButton
                ), // Padding
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
    )
      ], // Widget
    ))); // Stack, Column, MaterialApp
} 