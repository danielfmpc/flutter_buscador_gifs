import 'package:flutter/material.dart';

class GifPages extends StatelessWidget {

  final Map _gifData;

  GifPages(this._gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(_gifData["title"], style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),    
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_gifData["images"]["fixed_height"]["url"]),
      ),  
    );
  }
}