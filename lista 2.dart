import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {

  runApp(MaterialApp(
    home: Home(),
  )); // MaterialApp
} // main


class Home extends StatefulWidget {
  @overrride
  _HomeState createState () => _HomeState();
}

class _HomeState extends State<Home> {

  List _toDoList = [];

  @overrride
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista diaria"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ), // AppBar
      body: Column(
        children: <Widget> [
          Container(
            padding: EdgeInserts.FromTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Nova atividade",
                      labelStyle: TextStyle(color: Colors.redAccent),
                    ), // InputDecoration
                  ), // TextField
                ), // Expanded
                RaisedButton(
                  color: Colors.redAccent,
                  child: Text("ADD"),
                  textColor: Colors.white,
                  onPressed: () {},
                ), // RaisedButton
              ], // <Widget>[]
            ), // Row
          ) // Container
        ], // <Widget>[]
      ), // Column
    ); // Scaffold
  } // widget build

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  } //_getFile

  Future<File> _saveData() async{
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  } // _saveData

  Future<String> _readData() async{
    try{
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  } // _readData

} // _HomeState
