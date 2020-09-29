import 'package:flutter/material.dart';
import 'package:webview_gameout/routes/my_web_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => MyWebView(
                  title: 'Alligator.io',
                  selectedUrl: 'https://alligator.io',
                  //selectedUrl: 'https://www.bgames.com/',
                ),
              ));
            },
            child: Text('WebView Server Page'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => MyWebView(
                  title: 'Local WebView',
                  selectedUrl: 'assets/local.html',
                ),
              ));
            },
            child: Text('webView Local Page'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => MyWebView(
                  title: 'BG Games.com',
                  selectedUrl: 'https://www.bgames.com/',
                ),
              ));
            },
            child: Text('WebView Remote Games'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => MyWebView(
                  title: 'Local BGames.html',
                  selectedUrl: 'assets/bgames.html',
                ),
              ));
            },
            child: Text('Local BGames.com html'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => MyWebView(
                  title: 'Babylonjs Sample1',
                  selectedUrl: 'assets/babylonjs/sample1.html',
                ),
              ));
            },
            child: Text('Babylon sample1'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => MyWebView(
                  title: 'Babylonjs Complex game',
                  selectedUrl: 'assets/babylonjs/runner/public/index.html',
                ),
              ));
            },
            child: Text('Babylon Full Game'),
          ),
        ],
      ),
    );
  }
}
