import 'dart:io';

import 'package:briefy/constants.dart';
import 'package:briefy/model/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Utils {
  static void setStatusBarColor(Color color) {
    Future.delayed(
        Duration(milliseconds: 1),
        () => SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(statusBarColor: color)));
  }

  static Color getMainColorByLevel(Level level) {
    switch (level) {
      case Level.red:
        return AppColors.mainRed;
      case Level.yellow:
        return AppColors.mainYellow;
      case Level.green:
        return AppColors.mainGreen;
    }
  }

  static Color getLightColorByLevel(Level level) {
    switch (level) {
      case Level.red:
        return AppColors.lightRed;
      case Level.yellow:
        return AppColors.lightYellow;
      case Level.green:
        return AppColors.lightGreen;
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
      case 0:
        return Level.red;
      case 1:
        return Level.yellow;
      case 2:
        return Level.green;
      default:
        throw Exception('Wrong index provided');
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

  static String getMonthByNumber(int month) {
    switch (month) {
      case 1:
        return 'января';
      case 2:
        return 'февраля';
      case 3:
        return 'марта';
      case 4:
        return 'апреля';
      case 5:
        return 'мая';
      case 6:
        return 'июня';
      case 7:
        return 'июля';
      case 8:
        return 'августа';
      case 9:
        return 'сентября';
      case 10:
        return 'октября';
      case 11:
        return 'ноября';
      case 12:
        return 'декабря';
      default:
        throw Exception('Invalid month provided');
    }
  }

  static String editedTimeToString(DateTime edited) {
    edited = edited.toLocal();
    final now = DateTime.now().toLocal();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final ymdEdited = DateTime(edited.year, edited.month, edited.day);

    final DateFormat formatter = DateFormat('HH:mm');
    final String formatted = formatter.format(edited);

    if (ymdEdited == today) {
      return 'сегодня в $formatted';
    } else if (ymdEdited == yesterday) {
      return 'вчера в $formatted';
    } else {
      return '${edited.day} ${getMonthByNumber(edited.month)} в $formatted';
    }
  }

  static Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      return await sourceFile.rename(newPath);
    } catch (e) {
      final newFile = await sourceFile.copy(newPath);
      return newFile;
    }
  }
}

class DeletedNotesBuffer {
  static List<Note> _notesList = [];
  final _safeTime = Duration(seconds: 5);

  void _delayedRemoval() => Future.delayed(_safeTime, () => _notesList = []);

  void add(Note note) {
    _notesList.add(note);
    _delayedRemoval();
  }

  Note get() => _notesList.single;
}
