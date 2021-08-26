import 'dart:ui';
import 'package:briefy/model/note.dart';
import 'package:flutter/material.dart';

class AddingNoteForm {
  static Future show(BuildContext context, Function callback, Level level) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        // barrierColor: Colors.red,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.6,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Container(
                height: 5,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Новая заметка',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextField(
                maxLines: 2,
                maxLength: 128,
                autofocus: true,
                decoration: InputDecoration(hintText: 'Название'),
              ),
            ],
              ),
          );
        }).whenComplete(() {
      // callback(); // раскомментировать, если нужно размытие
    });
  }
}
