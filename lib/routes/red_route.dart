import 'package:briefy/components/lists/add_note_button.dart';
import 'package:briefy/components/lists/background.dart';
import 'package:briefy/components/lists/note_list.dart';
import 'package:briefy/constants.dart';
import 'package:briefy/model/note_model.dart';
import 'package:flutter/material.dart';

class RedRoute extends StatefulWidget {
  @override
  _RedRouteState createState() => _RedRouteState();
}

class _RedRouteState extends State<RedRoute> {
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
      floatingActionButton: AddNoteButton(Level.red),
      body: Stack(
        children: [
          AnimatedBackground(Level.red),
          NoteList(Level.red),
        ],
      ),
    );
  }
}
