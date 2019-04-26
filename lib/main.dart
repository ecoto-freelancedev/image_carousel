import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:image_carousel/model/image_model.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';


void main() {
  runApp(MyApp());
}

final ThemeData themeData = ThemeData(
  primaryColorDark: const Color(0xFF000a12),
  primaryColorLight: const Color(0xFF4f5b62),
  primaryColor: const Color(0xFF263238),
  accentColor: const Color(0xFF000000),
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Home(),
      theme: themeData,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  ImageModel imageModel;
  ImageList imgList;
  Map<String, String> headers;

  Future<String> _loadImageAsset() async {
    return await rootBundle.loadString('json/banner.json');
  }

  Future<ImageList> _loadImage() async {
    String jsonString = await _loadImageAsset();
    final jsonResponse = json.decode(jsonString);
    ImageList imgList = new ImageList.fromJson(jsonResponse);
    imgList.images.forEach((e) {
      headers.addAll(e.toJson());
    });
    //print(headers);
    return imgList;
  }

  @override
  void initState() {
    super.initState();
    imgList = new ImageList();
    headers = new Map<String, String>();
    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Series Carousel'),
      ),
      backgroundColor: const Color(0xFF4f5b62),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: 200.0,
          width: 400.0,
          child: FutureBuilder<ImageList>(
            future: _loadImage(),
            builder: (BuildContext context, AsyncSnapshot<ImageList> snapshot) {
              if(snapshot.data == null){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else {
                return Carousel(
                  images: snapshot.data.images.map((i) =>
                      NetworkImage(i.image,headers: headers)
                  ).toList(),
                  animationCurve: Curves.bounceOut,
                  animationDuration: Duration(milliseconds: 1000),
                  indicatorBgPadding: 10,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}