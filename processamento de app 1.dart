import 'package:cloud_firestone/cloud_firestone.dart';
import 'package:flutter/material.dart';

class ChatNet extends StatefullWidget {
  @override
  _ChatNetState createState() => _ChatNetState();
}

class _ChatNetState extends State<ChatNet> {
  
  void _sendMessage(String text) {
    Firestore.instance.collection('messages').add({
      'text': text
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo'),
        elevation: 0.0,
      ), // AppBar
      body: TextComposer(_sendMessage), 
    ); // Scaffold
  } // Widget build
} // _ChatNetState