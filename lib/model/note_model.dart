// todo: переделать images со списка URI (String) на список изображений
// todo: добавить дедлайн, после которого переносить заметку на уровень выше
// todo: добавить теги
import 'package:image_picker/image_picker.dart';

enum Level { red, yellow, green }

class NoTitleException {}

class NoteModel {
  final int id;
  Level level;
  bool isPinned = false;
  String title;
  String text;
  List<XFile> images;

  NoteModel({
    required this.id,
    required this.level,
    this.title = '',
    this.text = '',
    this.images = const [],
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
