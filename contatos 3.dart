import 'dart:async';
import 'dart:io';
import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;
  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact = _editedContact;
  bool _userEdited = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    if(widget.contact == null){
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());
      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(_editedContact.name ?? "Novo Contato"),
        centerTitle: true,
      ), // AppBar
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(_editedContact.name != null && _editedContact.name.isNotEmpty) {
            Navigator.pop(context, _editedContact);
          } else {
            FocusScope.of(context).requestFocus(_nameFocus);
          }
        }, // onPressed
        child: Icon(Icons.save),
        backgroundColor: Colors.blue,
      ), // FloatingActionButton
      body: SingleChildScrollView(
        padding: EdgeInsets.all(11.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 180.0,
                height: 180.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _editedContact.img != null ?
                    FileImage(File(_editedContact.img)) :
                    AssetImage("images/person.png"),
                    fit: BoxFit.cover
                  ), // DecorationImage
                ), // BoxDecoration
              ), // Container
            ), // GestureDetector
            TextField(
              controller: _nameController,
              focusNode: _nameFocus, 
              decoration: InputDecoration(labelText: "Nome"),
              onChanged: (text) {
                _userEdited = true;
                setState(() {
                  _editedContact.name = text;
                }); // setState
              }, // onChanged
            ), // TextField
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
              onChanged: (text) {
                _userEdited = true;
                _editedContact.email = text;
              }, // onChanged
              keyboardType: TextInputType.emailAddress,
            ), // TextField
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone"),
              onChanged: (text) {
                _userEdited = true;
                _editedContact.phone = text;
              }, // onChanged
              keyboardType: TextInputType.phone,
            ), // TextField
          ], // <Widget>[]
        ), // Column
      ), // SingleChildScrollView
    ); // Scaffold
  } // Widget build
} // _ContactPageState