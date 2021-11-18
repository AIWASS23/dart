import 'package:cloud_firestone/cloud_firestone.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());

  QuerySnapshot snapshot = await Firestone.instance.collection("mensagens").getDocument();
  snapshot.documents.forEach((m) {
    print(m.data);
  }); // forEach lendo todos os documentos da coleção 

  DocumentSnapshot snapshot = await Firestone.instance.collection("mensagens").document('msg1').get();
  print(snapshot.data); // lendo um texto especifico
  
  QuerySnapshot snapshot = await Firestone.instance.collection("mensagens").getDocument();
  snapshot.documents.forEach((m) {
    print(m.documentID);
  }); // lendo o ID dos documentos

  QuerySnapshot snapshot = await Firestone.instance.collection("mensagens").getDocument();
  snapshot.documents.forEach((m) {
    m.reference.updateData({'lido': 'false'})
  }); // escrever em todos os arquivos

  Firestone.instance.collection("mensagens").snapshots().listen((dado){
    dado.documents.forEach((m){
      print(m.data);
    }); // forEach
  }); // listen lendo dados em tempo real

  Firestone.instance.collection("mensagens").document('msg1').snapshots().listen((dado){
    print(dado.data)
  }); // listen lendo dados de um documento especifico em tempo real


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "chatnet",
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ), // ThemeData
      home: Container(),
    ); // MaterialApp
  } // Widget build
} // MyApp