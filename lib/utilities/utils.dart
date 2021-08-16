import 'package:briefy/model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  static void setStatusBarColor(Color color) {
    Future.delayed(
        Duration(milliseconds: 1),
        () => SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(statusBarColor: color)));
  }

  static Color getColorByLevel(Level level) {
    switch (level) {
      case Level.red:
        return Colors.red;
      case Level.yellow:
        return Colors.yellow;
      case Level.green:
        return Colors.green;
    }
  }

  static Level getNextLevel(Level level) {
    switch (level) {
      case Level.red:
        return Level.yellow;
      case Level.yellow:
        return Level.green;
      case Level.green:
        return Level.red;
    }
  }
}
