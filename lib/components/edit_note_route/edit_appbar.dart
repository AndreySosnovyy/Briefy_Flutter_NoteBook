import 'package:flutter/material.dart';

class EditAppbar extends AppBar {
  final String titleText;
  final appbarActionOval;

  EditAppbar(this.titleText, this.appbarActionOval)
      : super(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          brightness: Brightness.light,
          title: Text(
            titleText,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          actions: [
            appbarActionOval,
            SizedBox(width: 14),
          ],
        );
}
