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
                  selectedUrl: 'local.html',
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
        ],
      ),
    );
  }
}
