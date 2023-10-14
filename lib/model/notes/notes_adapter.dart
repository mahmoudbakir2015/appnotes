import 'package:appnotes/model/notes/notes_model.dart';

import 'package:hive/hive.dart';

class NotesAdapter extends TypeAdapter<NoteModel> {
  @override
  NoteModel read(BinaryReader reader) {
    return NoteModel(
      title: reader.readString(),
      date: reader.readString(),
      description: reader.readString(),
      index: reader.readInt(),
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer.writeString(obj.date);
    writer.writeString(obj.description);
    writer.writeString(obj.title);

    writer.writeInt(obj.index);
  }
}
