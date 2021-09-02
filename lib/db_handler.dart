import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'constants.dart';
import 'model/note.dart';

class DBHandler {
  static final DBHandler _instance = DBHandler._internal();

  factory DBHandler() => _instance;

  Box<Note> noteBox = Hive.box<Note>(Constants.notesBoxName);

  DBHandler._internal();

  int getNewId() {
    var id = 0;
    noteBox.values.forEach((note) {
      if (id <= note.id) {
        id = note.id + 1;
      }
    });
    return id;
  }

  Future<void> addNote(Note note) => noteBox.add(note);

  Note getNoteById(int id) {
    try {
      return noteBox.values.where((note) => note.id == id).single;
    } catch (e) {
      rethrow;
    }
  }

  List<Note> getNotes([Level? level]) {
    if (level != null) {
      return noteBox.values.where((note) => note.level == level).toList();
    } else {
      return noteBox.values.toList();
    }
  }

  Future<void> deleteNote(int id) async {
    noteBox.values.forEach((note) {
      if (note.id == id) {
        note.delete();
      }
    });
  }

  Future<void> clearNotesBox() async {
    var docPath = (await getApplicationDocumentsDirectory()).path;
    Directory(docPath + '/images').list().forEach((image) => image.delete());
    await noteBox.clear();
  }
}
