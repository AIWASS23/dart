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
  final _toDoController = TextEdintingController();
  List _toDoList = [];

  @overrride
  void iniState() {
    super.iniState();
    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      }); // setState
    }); // then
  } // iniState

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = _toDoController.text;
      _toDoController.text = "";
      newToDo["ok"] = false;
      _toDoList.add(newToDo);
      _saveData();
    }); // setState
  } // _addToDo

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
                    controller: _toDoController,
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
                  onPressed: _addToDo {},
                ), // RaisedButton
              ], // <Widget>[]
            ), // Row
          ), // Container
          Expanded(
            child: ListView.builder(
              padding: EdgeInserts.only(top: 10.0),
              itemCount: _toDoList.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(_toDoList[index]["title"]),
                  value: _toDoList[index]["ok"],
                  secondary: CirculeAvatar(
                    child: Icon(_toDoList[index]["ok"] ?
                      Icons.check : Icons.error,
                  onChanged: (c) {
                    setState(() {
                      _toDoList[index]["ok"] = c;
                      _saveData();
                    }); // setState
                  }, // onChanged
                    ), // Icon 
                  ), // CirculeAvatar
                ); // CheckboxListTile
              }, // itemBuilder  
            ), // ListView
          ), // Expanded
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
