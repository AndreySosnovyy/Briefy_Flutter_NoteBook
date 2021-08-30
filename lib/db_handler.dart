import 'package:hive/hive.dart';
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

  Future<void> clearNotesBox() async => await noteBox.clear();
}
