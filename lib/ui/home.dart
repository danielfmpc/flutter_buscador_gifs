import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _search;
  _getGifs() async {
    http.Response response;

    if (_search == null)
      response = await http.get("https://api.giphy.com/v1/gifs/trending?api_key=nr4Dvft5yHSY2x83Y3hxY6kTO1o99t3T&limit=20&rating=G");
    else 
      response = await http.get("https://api.giphy.com/v1/gifs/search?api_key=nr4Dvft5yHSY2x83Y3hxY6kTO1o99t3T&q=$_search&limit=25&offset=75&rating=G&lang=en");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}