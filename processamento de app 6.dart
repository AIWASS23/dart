import 'package:cloud_firestone/cloud_firestone.dart';
import 'package:flutter/material.dart';
import 'package:chat/text_composer.dart';
import 'dart:io';
import 'package:chat/chat_message.dart';
import 'package:firebase_storagefirebase_storage.dart';
import 'pacckage:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatNet extends StatefullWidget {
  @override
  _ChatNetState createState() => _ChatNetState();
}

class _ChatNetState extends State<ChatNet> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseUser _currentUser;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      setState(() {
        _currentUser = user;
      }); // setState
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
      ) // SnackBar
    ); // showSnackBar
  }

    Map<String, dynamic> data = {
      "uid": user.uid,
      "senderName": user.displayName,
      "senderPhotoUrl": user.photoUrl,
      "time": Timestamp.now(),
    }; // Map

    if(imgFile != null) {
     // StorageUploadTask task = FirebaseStorage.instance.ref().child(uid).child(DateTime.now().millisecondsSinceEpoch.toString()).putFile(imgFile);
      StorageUploadTask task = FirebaseStorage.instance.ref().child(user.uid + DateTime.now().millisecondsSinceEpoch.toString()).putFile(imgFile);

      setState(() {
        _isLoading = true;
      }); // setState

      StorageTaskSnapshot taskSnapshot = await task.onComplite;
      String url = await taskSnapshot.ref.getDownloadURL();
      data['imgUrl'] = url;

      setState(() {
        _isLoading = false;
      }); // setState

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
        title: Text(_currentUser != null ? 'Ola', ${_currentUser.displayName} : 'ChatNet'),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          _currentUser != null ? IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              googleSignIn.signOut();
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text('Até a Proxima'),
                  backgroundColor:Colors.green,
                ) // SnackBar
              ); // showSnackBar
            }, // onPressed
          ) : Container() // IconButton
        ], // <Widget>
      ), // AppBar
      body: Colunm(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection().orderBy('time').snapshots(),
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
                      return ChatMessage(
                        documents[index].data,
                        documets[index].data['uid'] == _currentUser?.uid,
                      ); // ChatMessage
                    }, // itemBuilder
                  ); // ListView.builder
                }; //switch
              }, // builder
            ), // StreamBuilder
          ), // Expanded
          _isLoading ? LinearProgressIndicator() : Container(),
          TextComposer(_sendMessage), 
        ], // <Widget>[]
      ), // Colunm
    ); // Scaffold
  } // Widget build
} // _ChatNetState