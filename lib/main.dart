import 'package:buscador_gifs/ui/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        hintColor: Colors.white,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          // focusedBorder:
          //   OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          // hintStyle: TextStyle(color: Colors.amber),
        )
      ),
    ) 
  );
}

