import 'dart:async';
import 'package:flutter/material.dart';

class BusyPage extends StatefulWidget {
  @override
  _BusyPageState createState() => _BusyPageState();
}

class _BusyPageState extends State<BusyPage> {
  Timer _timer;
  int _seconds = 0;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material (
      color: Colors.white,
      child: Center (
        child: Stack (
	alignment: Alignment.center,
	children: <Widget> [
	  Container (
	    width: 100, height: 100,
	    child: CircularProgressIndicator(),
	  ),
          Text(_seconds.toString(),
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
	],
	),
      ),
    );
  }

  @override
  void dispose() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }
}
