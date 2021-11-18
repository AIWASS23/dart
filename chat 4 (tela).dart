import 'package:cloud_firestone/cloud_firestone.dart';
import 'package:flutter/material.dart';

class TextComposer extends StatefullWidget {
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  bool _isComponsing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInserts.symmetric(horizontal: 10.0);
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () {

            }, // onpressed
          ), // IconButton
          Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(hintText: "Enviar Mensagem"),
              onChanged: (text) {
                setState(() {
                  _isComponsing = text.isNotEmpty;
                }); // setState
              }, // onChanged
              onSubmitted: (text) {

              }, onSubmitted
            ), // TextField
          ), // Expanded
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isComponsing ? () {

            } : null, // onpressed
          ), // IconButton
        ], // <Widget>[]
      ), // Row
    ); // Container
  } // Widget build
} // _ChatNetState
