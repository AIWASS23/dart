import 'package:cloud_firestone/cloud_firestone.dart';
import 'package:flutter/material.dart';
import 'package:chat/text_composer.dart';
import 'dart:io';

class ChatNet extends StatefullWidget {
  @override
  _ChatNetState createState() => _ChatNetState();
}

class _ChatNetState extends State<ChatNet> {
  
  void _sendMessage({String text, File imgFile}) async {

    Map<String, dynamic> data = {};

    if(imgFile != null) {
      StorageUploadTask task = FirebaseStorage.instance.ref().child(DateTime.now().millisecondsSinceEpoch.toString()).putFile(imgFile);
      StorageTaskSnapshot taskSnapshot = await task.onComplite;
      String url = await taskSnapshot.ref.getDownloadURL();
      data['imgUrl'] = url;
    }

    if(text != null) {
      data['text'] = text;
    }

    Firestore.instance.collection('messages').add(data);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo'),
        elevation: 0.0,
      ), // AppBar
      body: Colunm(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection().snapshots(),
              builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                  case ConnectionState.nome:
                  case ConnectionState.waitine:
                    return Center(
                      child: CircularProgressIndication(),
                    ); // Center
                  default: List<DocumentSnapshot> documents = snapshot.data.documents.reversed.toList();
                  return ListView.builder(
                    itemCount: documets.leigth,
                    reverse: true
                    itemBuilder: (context, index) {
                      return ListTitle(
                        title: Text(documets[index].data['texto']),
                      ); // ListTitle
                    }, // itemBuilder
                  ); // ListView.builder
                }; //switch
              }, // builder
            ), // StreamBuilder
          ), // Expanded
          TextComposer(_sendMessage), 
        ], // <Widget>[]
      ), // Colunm
    ); // Scaffold
  } // Widget build
} // _ChatNetState