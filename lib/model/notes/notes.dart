class Note {
  int index;
  String title;
  String description;
  String date;
  List<Note> notesDeleted;
  Note({
    required this.index,
    required this.date,
    required this.description,
    required this.title,
    required this.notesDeleted,
  });

  Note decrementIndex() {
    return Note(
      index: index - 1,
      date: date,
      description: description,
      title: title,
      notesDeleted: notesDeleted,
    );
  }
}
