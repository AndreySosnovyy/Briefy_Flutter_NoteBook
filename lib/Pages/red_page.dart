import 'package:briefy/components/note_list.dart';
import 'package:briefy/constants.dart';
import 'package:briefy/model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:briefy/components/background.dart';

class RedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Constants.appName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.add,
          size: 38,
        ),
        onPressed: () {},
      ),
      body: Stack(
        children: [
          AnimatedBackground(Level.red),
          NoteList(Level.red),
        ],
      ),
    );
  }
}
