import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_gameout/BLoC/local_html.dart';


class MyWebView extends StatelessWidget {
  final String title;
  final String selectedUrl;

  MyWebView({Key key, @required this.title, @required this.selectedUrl})
      : super(key: key);

  final Set<String> _urlSet = Set();

  @override
  Widget build(BuildContext context) {
    WebViewController _controller;
    // Check if the given Url is local or server
    String _initialUrl = '';
    if (selectedUrl.substring(0, 8) == "https://") {
      _initialUrl = selectedUrl;
    }

    return WillPopScope (
      onWillPop: () async {
        bool _retValue = true;
        if (_urlSet.isNotEmpty) {
          _urlSet.remove(_urlSet.last);
	}
        if (_urlSet.isNotEmpty) {
          _controller.loadUrl(_urlSet.last);
          _retValue = false;
        }
        return _retValue;
      },
      child: Scaffold(
      appBar: AppBar(title: Text(title)),
      body: WebView(
        initialUrl: _initialUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          _controller = webViewController;
          if (_initialUrl == '') {
            /// local url
            String _localUri = await LocalHtml(selectedUrl).uri;
            _controller.loadUrl(_localUri);
          } else {
            /// remote url
	    /// Nothing to do as it is specified in initialUrl
            //Completer <WebViewController>().complete(_controller);
          }
        },
        navigationDelegate: _interceptNavigation,
        onPageStarted: (String url) {},
        onPageFinished: (String url) {
	  _urlSet.add(url);
        },
        onWebResourceError: (error) {},
        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.require_user_action_for_all_media_types,
      ),
      ),
    );
  }
  /// NavigationRequest: url, isForMainFrame
  /// NavigationDecision: navigate, prevent
  NavigationDecision _interceptNavigation(NavigationRequest request) {
    NavigationDecision _navDecision = NavigationDecision.navigate;
    return _navDecision;
  }
}
