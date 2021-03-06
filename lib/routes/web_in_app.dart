import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_gameout/BLoC/local_html.dart';

class WebInApp extends StatelessWidget {
  final String title;
  final String selectedUrl;

  WebInApp({Key key, @required this.title, @required this.selectedUrl})
      : super(key: key);

  final Set<String> _urlSet = Set();

  /// webController is non final for now.
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    /// Check if the given Url is local or server
    String _initialUrl = '';
    if (selectedUrl.substring(0, 8) == "https://") {
      /// remote url, can be loaded directly in web view
      _initialUrl = selectedUrl;
    } else if (selectedUrl.substring(1, 5) == "data") {
      /// downloaded game, index file starts with '/data/...'
      _initialUrl = "file://" + selectedUrl;
      //_initialUrl = '';
    } else if (selectedUrl.substring(0,6) == 'assets'){
      /// local html page from assets 'assets/...'
      _initialUrl = "file:///android_asset/flutter_assets/" + selectedUrl;
    } else {
      /// can not be loaded directly, load with loadUrl()
      _initialUrl = '';
    }
    print('---- web view startup url: $_initialUrl ----');

    return WillPopScope(
      /// WillPopScope is to handle the back button
      /// intercept and see if go back to app or previous page in web
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
              /// local url,
              String _localUri = await LocalHtml(selectedUrl).uri;
              _controller.loadUrl(_localUri);
            } else {
              /// remote url
              /// Nothing to do as it is specified in initialUrl
              // Completer <WebViewController>().complete(_controller);
            }
          },
          navigationDelegate: _interceptNavigation,
          onPageStarted: (String url) async {},
          onPageFinished: (String url) {
            _urlSet.add(url);
          },
          onWebResourceError: (error) {},
          initialMediaPlaybackPolicy:
              AutoMediaPlaybackPolicy.require_user_action_for_all_media_types,
        ),
      ),
    );
  }

  /// NavigationRequest: url, isForMainFrame
  /// NavigationDecision: navigate, prevent
  Future<NavigationDecision> _interceptNavigation(
      NavigationRequest request) async {
    NavigationDecision _navDecision = NavigationDecision.navigate;
    print('----- local url: ${request.url} ----');
    if (request.url.substring(0, 8) == "asset://") {
      /// Local html file internal link eg:"assets/bgames.html"
      /// it won't show any thing in the webView
      /// if it is not url, load the content from assets
      print('----- local file: ${request.url.substring(8)} -----');
      String _localUri = await LocalHtml(request.url.substring(8)).uri;

      /// load local asset file after converting to url
      _controller.loadUrl(_localUri);

      /// Not loading the asset url
      //_navDecision = NavigationDecision.prevent;
    }
    return _navDecision;
  }
}
