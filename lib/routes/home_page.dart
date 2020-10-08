import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_gameout/routes/web_in_app.dart';
import 'package:webview_gameout/routes/busy_page.dart';
import 'package:webview_gameout/BLoC/download_zip.dart';

/// This will have links to different types of games
/// that we test
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Container of Games'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          /// Load any website to webview
          buttonContainer(context: context, url: "https://alligator.io",
	    text: 'Webpage alligator.io'),
          /// load local single html file to webview
          buttonContainer(context: context, url: "assets/local.html",
	    text: 'WebView Local page'),
          /// Test with website which can run games
          /// check gestures, audio, video etc are ok
          buttonContainer(context: context, url: "https://www.bgames.com/",
	    text: 'Remote game in WebView'),
          /// Test website with games from local files
          buttonContainer(context: context, url: "assets/bgames.html",
	    text: 'Local BGames.com html'),
          /// Simple babylon.js game (single file)
          buttonContainer(context: context,
            url: "assets/sample1.html",
	    text: 'Babylonjs Simple Game'),
          ///
          /// SoundBox basic + sound from array buffer
          ///
          buttonContainer(context: context,
            url: "https://firebasestorage.googleapis.com/v0/b/gameout-68dab.appspot.com/o/webview%2Fsoundbox.sound.zip?alt=media&token=feeb0d5e-31ab-42ef-928e-394381f2cd20",
	    text: 'Downloaded SoundBox with sound'),
	  ///
	  /// soundBox with sound and texture
	  ///
          buttonContainer(context: context,
            url: "https://firebasestorage.googleapis.com/v0/b/gameout-68dab.appspot.com/o/webview%2Fsoundbox.sound.texture.zip?alt=media&token=deeb8b08-bba2-42c5-bf2e-b4c11fc370ce",
	    text: 'SoundBox with Sound & Texture'),
        ],
      ), 
    );
  }
  Widget buttonContainer({@required BuildContext context, Color color = Colors.white, @required String url, String text = 'click'}) {
    double _width = MediaQuery.of(context).size.width;
    return Container (
	  height: 30, width: _width,
	  margin: EdgeInsets.symmetric(vertical:5, horizontal:10),
	  decoration: BoxDecoration (
	    color: color,
	    borderRadius: BorderRadius.circular(5),
	    border: Border.all(color: Colors.black),
	  ),
          child: FlatButton(
            onPressed: () async {
	      Navigator.of(context).push(MaterialPageRoute(
	        builder: (_) => BusyPage(),
		)
              );
              String _downloadUrl = url;
              /// downloading zip file will take some time,
              /// make use of FutureBuilder for actual project
              /// Files will be downloaded every time this button is clicked.
              /// Ok for testing purpose.
              /// if 'index.html' already exist in specified folder then
              /// download can be skipped.
	      RegExp _regExp = new RegExp (r'2F(.+).zip');
	      String zipFilename = _regExp.stringMatch(url);
              String _indexFile;
              String _path = (await getApplicationDocumentsDirectory()).path;
	      if ( zipFilename != null && zipFilename.length > 0) {
	        zipFilename = zipFilename.substring(2, zipFilename.length - 4);
	        print('--------- $zipFilename ----------');
                _indexFile = _path + '/$zipFilename/index.html';
                await DownloadZip(_downloadUrl).getFiles();
              } else {
	        _indexFile = url;
	      }
              /// specify the relative path to index file in above zip file
              /// this is the file which will be loaded to WebView as startup page

              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (_) => WebInApp(
                  title: text,
                  selectedUrl: _indexFile,
                ),
              ));
            },
            child: Text(text, overflow: TextOverflow.ellipsis),
          ),
    );
  }
}
