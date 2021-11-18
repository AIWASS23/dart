import 'package:cloud_firestone/cloud_firestone.dart';
import 'package:flutter/material.dart';
import 'package:chat/text_composer.dart';
import 'dart:io';

class ChatNet extends StatefullWidget {
  @override
  _ChatNetState createState() => _ChatNetState();
}

class _ChatNetState extends State<ChatNet> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseUser _currentUser;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      _currentUser = user;
    }); // listen
  }

  Future<FirebaseUser> _getUser() async {
    if(_currentUser != null) {
      return _currentUser;
    }

    try{
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthCredential.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken:googleSignInAuthentication.accessToken,
      ); // getCredential

      final AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
      final FirebaseUser user =authResult.user;

      return user;
      
    } catch(error){
      return null;
    }
  } // <FirebaseUser>

  void _sendMessage({String text, File imgFile}) async {
   // final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final FirebaseUser user = await _getUser();

  if(user == null) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('Não foi possivel logar'),
        backgroundColor:Colors.blue,
      ) // snackBar
    ); // showSnackBar
  }

    Map<String, dynamic> data = {
      "uid": user.uid,
      "senderName": user.displayName,
      "senderPhotoUrl": user.photoUrl,
    }; // Map

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
  } // _sendMessage
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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