import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

class LocalHtml {
  String fileName;
  LocalHtml(this.fileName);

  Future<String> get uri async {
    String fileHtmlContents = await rootBundle.loadString('assets/$fileName');
    //print ('----- fileHtmlContents: $fileHtmlContents -----');
    String _uriString =  Uri.dataFromString (fileHtmlContents,
      mimeType:"text/html",
      encoding: Encoding.getByName('utf-8'),
    ).toString();
    return _uriString;
  }
}
