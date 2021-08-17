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

  static int getIndexByLevel(Level level) {
    switch (level) {
      case Level.red:
        return 0;
      case Level.yellow:
        return 1;
      case Level.green:
        return 2;
    }
  }

  static Level getLevelByIndex(int index) {
    switch (index) {
      case 0: return Level.red;
      case 1: return Level.yellow;
      case 2: return Level.green;
      default: throw Exception('Wrong index provided');
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
