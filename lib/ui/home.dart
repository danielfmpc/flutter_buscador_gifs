import 'dart:convert';

import 'package:buscador_gifs/ui/gifs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _search;
  int _offset;


  Future<Map> _getGifs() async {
    http.Response response;

    if (_search == null || _search.isEmpty)
      response = await http.get("https://api.giphy.com/v1/gifs/trending?api_key=nr4Dvft5yHSY2x83Y3hxY6kTO1o99t3T&limit=20&rating=G");
    else 
      response = await http.get("https://api.giphy.com/v1/gifs/search?api_key=nr4Dvft5yHSY2x83Y3hxY6kTO1o99t3T&q=$_search&limit=19&offset=$_offset&rating=G&lang=en");
    
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network("https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Pesquise aqui: ",
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                border: OutlineInputBorder(),
              ),                
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
              onSubmitted: (text){
                setState(() {
                  _search = text;  
                  _offset = 0;                    
                });
              },
            ),
          ),        
          Expanded(
            child: FutureBuilder(
              future: _getGifs(),
              builder: (context, snapshot){
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Container(
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                        strokeWidth: 5,
                      ),
                    );  
                    break;
                  case ConnectionState.done:
                    return _createGiftTable(context,snapshot);
                    break;
                  default:
                    if(snapshot.hasError) return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  int _getCount(List data){
    if(_search == null){
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  Widget _createGiftTable(BuildContext context, AsyncSnapshot snapshot){
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ), 
      itemCount: _getCount(snapshot.data["data"]),
      itemBuilder: (context, index){
        if(_search == null || index < snapshot.data["data"].length){
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => GifPages(snapshot.data["data"][index]),
                )
              );
            },
            onLongPress: (){
              Share.share(snapshot.data["data"][index]["images"]["fixed_height"]["url"]);
            },
            
            child: FadeInImage.memoryNetwork(
              image: snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              placeholder: kTransparentImage,
              height: 300,
              fit: BoxFit.cover,
            ),          
          );
        }
        else
          return Container(
            child: GestureDetector(
              onTap: (){
                setState(() {
                  _offset += 19;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add, color: Colors.white, size: 50,),
                  Text(
                    "Carregar mais...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          );
      }
    );
  }

}