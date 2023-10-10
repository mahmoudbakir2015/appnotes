import 'package:appnotes/model/notes/notes.dart';

import 'package:hive/hive.dart';

class NotesAdapter extends TypeAdapter<Note> {
  @override
  Note read(BinaryReader reader) {
    return Note(
      title: reader.readString(),
      date: reader.readString(),
      description: reader.readString(),
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Note obj) {
    writer.writeString(obj.date);
    writer.writeString(obj.description);
    writer.writeString(obj.title);
  }
}
