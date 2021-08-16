import 'package:briefy/components/adding/appbar_action_oval.dart';
import 'package:briefy/model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddNoteRoute extends StatelessWidget {
  AddNoteRoute(Level level);

  @override
  Widget build(BuildContext context) {
    var appbarActionOval = AppbarActionOval(Level.red);
    var noteTitleFieldController = TextEditingController();
    var noteTextFieldController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        title: Text(
          'Новая заметка',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          appbarActionOval,
          SizedBox(width: 6),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: noteTitleFieldController,
                maxLength: 128,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                  counterText: '',
                  border: InputBorder.none,
                  hintText: 'Название',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ScrollConfiguration(
                  behavior: NoGlowBehavior(),
                  child: TextField(
                    controller: noteTextFieldController,
                    maxLength: 2000,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    maxLines: null,
                    decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      hintText: 'Текст',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            )
            
          ],
        ),
      ),
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
