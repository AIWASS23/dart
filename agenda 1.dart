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
  
  @override
  void initState() {
    super.initState();

    Contact p = Contact();
    p.name = "marcelo";
    p.email = messi@gmail.com;
    p.phone = 987654321;
    p.img = "test";

    helper.getAllContacts().then((list) {
      print(list);
    }); // getAllContacts
  } // initState
} // _HomePageState

  