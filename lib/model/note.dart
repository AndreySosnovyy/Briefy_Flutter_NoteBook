import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';

part 'note.g.dart';

// todo: добавить дедлайн, после которого переносить заметку на уровень выше
// todo: добавить теги

@HiveType(typeId: 1)
enum Level {
  @HiveField(0)
  red,
  @HiveField(1)
  yellow,
  @HiveField(2)
  green
}

class NoTitleException {}

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  Level level;
  @HiveField(2)
  bool isPinned = false;
  @HiveField(3)
  String title = 'Новая заметка';
  @HiveField(4)
  String text = '';
  @HiveField(5)
  List<File> images = [];
  // todo: Unhandled Exception: HiveError: Cannot write, unknown type: _File.
  // Did you forget to register an adapter?
  @HiveField(6)
  DateTime created = DateTime.now();
  @HiveField(7)
  DateTime edited = DateTime.now();

  Note({
    required this.id,
    required this.level,
    required this.title,
    required this.text,
    required this.images,
  });

  Note.empty({
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
number of images: ${images.length}
edited: ${edited.toString()}
created: ${created.toString()}
''';
  }

  void validate() {
    if (title.isEmpty) {
      throw NoTitleException();
    }
  }
}
