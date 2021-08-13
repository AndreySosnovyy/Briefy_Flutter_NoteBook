// todo: переделать images со списка URI (String) на список изображений
// todo: добавить дедлайн для заметки (после которого уведомлять пользователя)
// todo: добавить дедлайн, после которого переносить заметку на уровень выше

enum Level { red, yellow, green }

class NoteModel {
  final int id;
  Level level;
  final String title;
  final String text;
  final List<String> images;
  bool isPinned = false;

  NoteModel({
    required this.id,
    required this.level,
    required this.title,
    required this.text,
    required this.images,
  });
}
