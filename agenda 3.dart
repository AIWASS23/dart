import 'dart:io';
import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:agenda_contatos/ui/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();
  List<Contact> contacts = List();

  @override
  void initState() {
    super.initState();
    helper.getAllContacts().then(() {
      setState(() {
        contacts = list;
      }); // setState
    }); // then
  } // initState

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ), // AppBar
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ), // FloatingActionButton
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return _contactCard(context, index);
        } // itemBuilder
      ), // ListView.builder
    ); // Scaffold
  } // Widget build
  
  Widget _contactCard(BuildContext context, int index){
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[index].img != null ?
                      FileImage(File(contacts[index].img)) :
                        AssetImage("images/person.png"),
                    fit: BoxFit.cover
                  ), // DecorationImage
                ), // BoxDecoration
              ), // Container
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(contacts[index].name ?? "",
                      style: TextStyle(fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                    ), // Text
                    Text(contacts[index].email ?? "",
                        style: TextStyle(fontSize: 18.0),
                    ), // Text
                    Text(contacts[index].phone ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ) // Text
                  ], // <Widget>[]
                ), // Column
              ) // Padding
            ], // <Widget> []
          ), // Row
        ), // Padding
      ), // Card
    ); // GestureDetector
  } // _contactCard

} //  _HomePageState
