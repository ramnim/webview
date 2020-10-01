import 'dart:io';
import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


/// This will download zip file from given url
/// Keeps the files in applicationDirectory
/// For Android, the app dir
/// is :/data/user/0/<com.example.webview_gameout>/app_flutter
class DownloadZip {
  String _url;
  DownloadZip (this._url);

  String _appDirPath;

  Future<String> get applicationDocsDir async{
    return (await getApplicationDocumentsDirectory()).path;
  }

  Future<void> getFiles() async {
    _appDirPath = await applicationDocsDir;
    var _tempFile = File('$_appDirPath/tempFile');
    //var _request = await http.Client().get(Uri.parse(_url));
    var _request = await http.get(Uri.parse(_url));
    //File _tempZipFile = await _tempFile.writeAsBytes(_request.bodyBytes);
    await _tempFile.writeAsBytes(_request.bodyBytes);
    //var _bytes = _tempZipFile.readAsBytesSync();
    //Uint8List _bytes = _tempFile.readAsBytesSync();
    Archive _archive = ZipDecoder().decodeBytes(_tempFile.readAsBytesSync());
    for (var file in _archive) {
      /// consider if the file in archive is regular file
      /// ignore if it is symbolic link etc
      if (file.isFile) {
        var _tempOutFile = File('$_appDirPath/${file.name}');
        await _tempOutFile.create(recursive: true);
        await _tempOutFile.writeAsBytes(file.content);
        int _length = _tempOutFile.lengthSync();
        print('------ ${_tempOutFile.path} size: $_length -------');
      }
    }
    /// delete the downloaded zip file
    await _tempFile.delete();
  }
}
