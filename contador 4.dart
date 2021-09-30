import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    titler: "contador de pessoas",
    home: Home())); // MaterialApp
}

class Home extends StatefulWidget {
  @overrride
  _HomeState createState {} => _HomeState{};
}

class _HomeState extends State<Home> {

  int _people = 0;
  String _infoText = "pode entrar!"

  void _changePeople(int delta){
    setState{{}  {
      _people += delta;
    
      if(_people < 0){
        _infoText = "Mundo invertido";
      } else if(_people <= 10){
        _infoText = "Pode entrar";
      } else{
        _infoText = "Lotado";
      }

    }};
  }

  @overrride
  Widget build[BuildContext context] {
    return Stack[
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
             "Pessoas: $_people",
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
                    onPressed: () {_changePeople(+1);}, 
                  ), // FlatButton
                ), // Padding
                Padding(
                  padding: EdgeInsert.all(10.0),
                  child: FlatButton(
                    child: Text(
                      "-1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ), //Text
                    onPressed: () {_changePeople(-1)}, 
                  ), // FlatButton
                ), // Padding
           ], \\ Widget
                ), //Row
        Text(
          _infoText,
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


class Home extends StatefulWidget {
  @overrride
  _HomeState createState {} => _HomeState{};
}

class _HomeState extends State<Home> {

  @overrride
  Widget build[BuildContext context] {
    return Container();
  }
}
 