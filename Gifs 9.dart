import 'dart:async';
import 'dart:convert';

import 'package:buscador_gifs/ui/gif_page.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _offset = 0;

  Future<Map> _getGifs() async {
    http.Response response;
    if(_search == null || _search.isEmpty)
      response = await http.get("https://api.giphy.com/v1/gifs/trending?api_key=wusbFwUExpkztfjeMr3QRimPUc4kd1J9&limit=20&rating=G");
    else
      response = await http.get("https://api.giphy.com/v1/gifs/search?api_key=wusbFwUExpkztfjeMr3QRimPUc4kd1J9&q=$_search&limit=19&offset=$_offset&rating=G&lang=en");
    return json.decode(response.body)
  } // <Map>_getGifs

  @override
  void initState() {
    super.initState();
    _getGifs().then((map) {
      print(map);
    }); // _getGifs.then
  } // initState

  @override
  Widget build(BuildContext context) {
    Return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Image.network("https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
        centerTitle: true,
      ), // AppBar
      backgroundColor: Colors.red,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(11.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Procure",
                labelStyle: TextStyle(color: Colors.green), 
                border: OutlineInputBorder()
              ), // InputDecoration
              style: TextStyle(color: Colors.pink, fontSize: 15.0),
              textAlign: TextAlign.center,
              onSubmitted: (text) {
                setState(() {
                  _search = text;
                  _offset = 0;   
                }); // setState
              }, // onSubmitted
            ), // TextField
          ), // Padding
          Expanded(
            child: FutureBuilder(
              future: _getGifs(),
              builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        strokeWidth: 5.5,
                      ), // CircularProgressIndicator
                    ); // Container
                  default:
                    if(snapshot.hasError) return Container();
                    else return _createGifTable(context, snapshot);
                } // switch
              } // builder
            ), // FutureBuilder
          ), // Expanded
        ], // <Widget>[]
      ), //Column
    ); // Scaffold
  } // Widget build

  int _getCount(List data) {
    if(_search == null || _search.isEmpty) {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  Widget _createGifTable(BuilderContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.all(11.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 11.0,
        mainAxisSpacing: 11.0,
      ), // SliverGridDelegateWithFixedCrossAxisCount
      itemCount: _getCount(snapshot.data["data"]),
      itemBuilder: (context, index) {
        if(_search == null || index < snapshot.data["data"].length) {
          return GestureDetector(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              height: 290.0,
              fit: BoxFit.cover,
            ), // FadeInImage
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => GifPage(snapshot.data["data"][index]));
              ); // Navigator
            }, // onTap
            onLongPress: () {
              Share.share(snapshot.data["data"][index]["images"]["fixed_height"]);
            }, // onLongPress
          ); // GestureDetector
        } // if
        else {
          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add, color: Colors.green, size: 71.0),
                  Text("Download",
                    style:TextStyle: (color: Colors.green, fontSize: 23.0),
                  ), // Text
                ], // <Widget>[]
              ), // Column
              onTap: () {
                setState(() {
                  _offset += 19;
                }); // setState
              }, //onTap
            ), // GestureDetector
          ); // Container
        } // else
      }, // itemBuilder
    ); // GridView.builder
  } // Widget _createGifTable
} // _HomePageState