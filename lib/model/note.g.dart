// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LevelAdapter extends TypeAdapter<Level> {
  @override
  final int typeId = 1;

  @override
  Level read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Level.red;
      case 1:
        return Level.yellow;
      case 2:
        return Level.green;
      default:
        return Level.red;
    }
  }

  @override
  void write(BinaryWriter writer, Level obj) {
    switch (obj) {
      case Level.red:
        writer.writeByte(0);
        break;
      case Level.yellow:
        writer.writeByte(1);
        break;
      case Level.green:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 0;

  @override
  Note read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Note(
      id: fields[0] as int,
      level: fields[1] as Level,
      title: fields[3] as String,
      text: fields[4] as String,
      images: (fields[5] as List).cast<File>(),
    )
      ..isPinned = fields[2] as bool
      ..created = fields[6] as DateTime
      ..edited = fields[7] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.level)
      ..writeByte(2)
      ..write(obj.isPinned)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.text)
      ..writeByte(5)
      ..write(obj.images)
      ..writeByte(6)
      ..write(obj.created)
      ..writeByte(7)
      ..write(obj.edited);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
