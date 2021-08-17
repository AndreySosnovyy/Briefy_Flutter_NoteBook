import 'package:briefy/components/lists/add_note_button.dart';
import 'package:briefy/components/lists/background.dart';
import 'package:briefy/components/lists/navigation_bar.dart';
import 'package:briefy/components/lists/note_list.dart';
import 'package:briefy/constants.dart';
import 'package:briefy/model/note_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GreenRoute extends StatefulWidget {
  @override
  _GreenRouteState createState() => _GreenRouteState();
}

class _GreenRouteState extends State<GreenRoute> {
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
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: CustomNavigationBar(Level.green, context),
      floatingActionButton: AddNoteButton(Level.green),
      body: Stack(
        children: [
          AnimatedBackground(Level.green),
          NoteList(Level.green),
        ],
      ),
    );
  }
}
