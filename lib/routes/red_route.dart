import 'package:briefy/components/lists/background.dart';
import 'package:briefy/components/lists/navigation_bar.dart';
import 'package:briefy/components/lists/note_list.dart';
import 'package:briefy/constants.dart';
import 'package:briefy/model/note_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RedRoute extends StatefulWidget {
  @override
  _RedRouteState createState() => _RedRouteState();
}

class _RedRouteState extends State<RedRoute> {

  var level = Level.red;

  void callback() {
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          Constants.appName,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      bottomNavigationBar: CustomNavigationBar(level, context),
      body: Stack(
        children: [
          AnimatedBackground(level),
          NoteList(level),
        ],
      ),
    );
  }
}
