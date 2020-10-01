import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_gameout/routes/web_in_app.dart';
import 'package:webview_gameout/BLoC/download_zip.dart';

/// This will have links to different types of games
/// that we test
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container of Games'),
      ),
      body: Column(
        children: <Widget>[
          /// Load any website to webview
          FlatButton(
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => WebInApp(
                  title: 'Alligator.io',
                  selectedUrl: 'https://alligator.io',
                ),
              ));
            },
            child: Text('WebView Server Page'),
          ),
          /// load local single html file to webview
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => WebInApp(
                  title: 'Local WebView',
                  selectedUrl: 'assets/local.html',
                ),
              ));
            },
            child: Text('webView Local Page'),
          ),
          /// Test with website which can run games
          /// check gestures, audio, video etc are ok
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => WebInApp(
                  title: 'BGames.com',
                  selectedUrl: 'https://www.bgames.com/',
                ),
              ));
            },
            child: Text('WebView Remote Games'),
          ),
          /// Test website with games from local files
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => WebInApp(
                  title: 'Local BGames.html',
                  selectedUrl: 'assets/bgames.html',
                ),
              ));
            },
            child: Text('Local BGames.com html'),
          ),
          /// Simple babylon.js game (single file)
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => WebInApp(
                  title: 'Babylonjs Sample1',
                  selectedUrl: 'assets/sample1.html',
                ),
              ));
            },
            child: Text('Babylon Single Page Game'),
          ),
          ///
          /// Game from local files with different folders, sounds, music files
          ///
          FlatButton(
            onPressed: () async {
              String _downloadUrl =
                  "https://firebasestorage.googleapis.com/v0/b/gameout-68dab.appspot.com/o/webview%2Fpublic.zip?alt=media&token=b494a893-464d-4637-82b0-ccce8baba2a3";
              /// downloading zip file will take some time,
              /// make use of FutureBuilder for actual project
              /// Files will be downloaded every time this button is clicked.
              /// Ok for testing purpose.
              /// if 'index.html' already exist in specified folder then
              /// download can be skipped.
              await DownloadZip(_downloadUrl).getFiles();
              String _path = (await getApplicationDocumentsDirectory()).path;
              /// specify the relative path to index file in above zip file
              /// this is the file which will be loaded to WebView as startup page
              String _indexFile = _path + '/public/index.html';

              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => WebInApp(
                  title: 'Game from Remote files',
                  selectedUrl: _indexFile,
                ),
              ));
            },
            child: Text('Download Remote Game'),
          ),
        ],
      ),
    );
  }
}
