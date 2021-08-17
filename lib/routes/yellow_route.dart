import 'package:briefy/components/lists/add_note_button.dart';
import 'package:briefy/components/lists/background.dart';
import 'package:briefy/components/lists/navigation_bar.dart';
import 'package:briefy/components/lists/note_list.dart';
import 'package:briefy/constants.dart';
import 'package:briefy/model/note_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YellowRoute extends StatefulWidget {
  @override
  _YellowRouteState createState() => _YellowRouteState();
}

class _YellowRouteState extends State<YellowRoute> {
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
        backgroundColor: Colors.yellow,
      ),
      bottomNavigationBar: CustomNavigationBar(Level.yellow, context),
      floatingActionButton: AddNoteButton(Level.yellow),
      body: Stack(
        children: [
          AnimatedBackground(Level.yellow),
          NoteList(Level.yellow),
        ],
      ),
    );
  }
}
