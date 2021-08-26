import 'package:hive/hive.dart';
import 'model/note.dart';

class DBHandler {
  static final DBHandler _instance = DBHandler._internal();

  DBHandler._internal();

  factory DBHandler() => _instance;

  var noteBox = Hive.box<Note>('notes');

  int getNewId() {
    var id = 0;
    noteBox.values.forEach((note) {
      if (id <= note.id) {
        id = note.id + 1;
      }
    });
    return id;
  }

  void addNote(Note note) => noteBox.add(note);

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
}
