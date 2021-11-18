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
    return container();
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
