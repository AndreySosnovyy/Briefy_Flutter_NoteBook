import 'package:flutter/material.dart';

class NoteTitleTextField extends TextField {
  final controller;
  final Function setDeletingImagesMode;
  final Function update;
  final Function updateTitle;

  NoteTitleTextField(
      {required this.controller,
      required this.setDeletingImagesMode,
      required this.update,
      required this.updateTitle})
      : super(
          onTap: () {
            setDeletingImagesMode(false);
            update();
          },
          controller: controller,
          onChanged: (text) => updateTitle(text),
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
        );
}

class NoteTextTextField extends TextField {
  final controller;
  final Function setDeletingImagesMode;
  final Function update;
  final Function updateText;

  NoteTextTextField(
      {required this.controller,
      required this.setDeletingImagesMode,
      required this.update,
      required this.updateText})
      : super(
          onTap: () {
            setDeletingImagesMode(false);
            update();
          },
          controller: controller,
          onChanged: (text) => updateText(text),
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
        );
}
