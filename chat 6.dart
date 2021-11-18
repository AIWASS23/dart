import 'package:cloud_firestone/cloud_firestone.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefullWidget {
  TextComposer(this.sendMessage);

  final Function({String text, File imgFile}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  final TextEditingController _controller = TextEditingController();
  bool _isComponsing = false;

  void _resert() {
    _controller.clear();
    setState((){
      _isComponsing = false;
    }); // setState
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInserts.symmetric(horizontal: 10.0);
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () async {
              final File imgFile = await ImagePicker.pickImage(source:ImageSource.camera);
              if(imgFile == null) return;
              widget.sendMessage(imgFile: imgFile);
            }, // onpressed
          ), // IconButton
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration.collapsed(hintText: "Enviar Mensagem"),
              onChanged: (text) {
                setState(() {
                  _isComponsing = text.isNotEmpty;
                }); // setState
              }, // onChanged
              onSubmitted: (text) {
                widget.sendMessage(text: text);
                _resert();
              }, onSubmitted
            ), // TextField
          ), // Expanded
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isComponsing ? () {
              widget.sendMessage(text: _controller.text);
              _resert();
            } : null, // onpressed
          ), // IconButton
        ], // <Widget>[]
      ), // Row
    ); // Container
  } // Widget build
} 
