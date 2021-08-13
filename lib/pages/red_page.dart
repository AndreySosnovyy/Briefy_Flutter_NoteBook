import 'package:briefy/components/adding_note_form.dart';
import 'package:briefy/components/blur.dart';
import 'package:briefy/components/note_list.dart';
import 'package:briefy/constants.dart';
import 'package:briefy/model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:briefy/components/background.dart';

class RedPage extends StatefulWidget {
  @override
  _RedPageState createState() => _RedPageState();
}

class _RedPageState extends State<RedPage> {
  bool isBlurred = false;

  void callback() {
    setState(() {
      isBlurred = !isBlurred;
    });
  }

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
        onPressed: () {
          // setState(() => isBlurred = !isBlurred); // раскомментировать, если нужно размытие
          AddingNoteForm.show(context, callback, Level.red);
        },
      ),
      body: Stack(
        children: [
          AnimatedBackground(Level.red),
          NoteList(Level.red),
          if (isBlurred) Blur(),
        ],
      ),
    );
  }
}
