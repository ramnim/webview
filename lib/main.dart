import 'package:flutter/material.dart';
import 'package:webview_gameout/routes/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return MaterialApp (
      title: 'Flutter WebView Demo',
      theme: ThemeData ( primarySwatch: Colors.blue,),
      home: HomePage(),
    );
  }
}
