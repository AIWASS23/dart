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
  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;

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
              itemBuilder: buildItem
            ), // ListView.buider
          ), // Expanded
        ], // <Widget>[]
      ), // Column
    ); // Scaffold
  } // widget build

  Widget buildItem (BuildContext context, int index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.yellow,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete, color: Colors.blue,),
        ), // Align
      ), // Container
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_toDoList[index]["title"]),
        value: _toDoList[index]["ok"],
        secondary: CirculeAvatar(
          child: Icon(_toDoList[index]["ok"] ?
          Icons.check : Icons.error), ), // Icon, CircleAvatar
        onChanged: (c) {
          setState(() {
            _toDoList[index]["ok"] = c;
            _saveData();
          }); // setState
        }, // onChanged
      ), // CheckboxListTile
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_toDoList[index]);
          _lastRemovedPos = index;
          _toDoList.removeAt(index);
          _saveData();

          final snack = SnackBar(
            content: Text("Tarefa \"${_lastRemoved["title"]}\" removida"),
            action: SnackBarAction(label: "Desfazer",
              onPressed: () {
                setState(() {
                  _toDoList.insert(_lastRemovedPos, _lastRemoved);
                  _saveData();
                }); // setState
            }), // SnackBarAction
            duration: Duration(seconds: 2), 
          ); // SnackBar
          Scaffold.of(context).showSnackBar(snack);
        }); // setState
      }, // onDismissed
    ); // Dismissible
  } // itemBuilder  

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
