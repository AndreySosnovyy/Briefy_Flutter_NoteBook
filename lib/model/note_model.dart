// todo: добавить дедлайн, после которого переносить заметку на уровень выше
// todo: добавить теги
import 'dart:io';

enum Level { red, yellow, green }

class NoTitleException {}

class NoteModel {
  final int id;
  Level level;
  bool isPinned = false;
  String title = '';
  String text = '';
  List<File> images = [];
  DateTime created = DateTime.now();
  DateTime edited = DateTime.now();

  NoteModel({
    required this.id,
    required this.level,
    required this.title,
    required this.text,
    required this.images,
  });

  NoteModel.empty({
    required this.id,
    required this.level,
  });

  @override
  String toString() {
    return '''id: $id
    level: $level
    is pinned: $isPinned
    title: $title
    text: $text
    number of images: ${images.length}''';
  }

  void validate() {
    if (title.isEmpty) {
      throw NoTitleException();
    }
  }
}
