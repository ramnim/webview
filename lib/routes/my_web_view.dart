import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_gameout/BLoC/local_html.dart';


class MyWebView extends StatelessWidget {
  final String title;
  final String selectedUrl;


  MyWebView({Key key, @required this.title, @required this.selectedUrl}) : super(key: key);

  @override
  Widget build (BuildContext context) {
    WebViewController _controller;
    // Check if the given Url is local or server
    String _initialUrl = '';
    if ( selectedUrl.substring(0,8) == "https://") {
      _initialUrl = selectedUrl;
    } 

    return Scaffold (
      appBar: AppBar (title: Text(title)),
      body: WebView (
        initialUrl: _initialUrl, 
	javascriptMode: JavascriptMode.unrestricted,
	onWebViewCreated: (WebViewController webViewController) async {
          _controller = webViewController;
          if ( _initialUrl == '') {
            String _localUri = await LocalHtml(selectedUrl).uri;
	    _controller.loadUrl(_localUri);
	  } else {
	    Completer <WebViewController>().complete(_controller);
	  }
	},
      ),
    );
  }
}
