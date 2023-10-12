class Note {
  final int index;
  final String title;
  final String description;
  final String date;
  List<Note> notesDeleted;
  Note({
    required this.index,
    required this.date,
    required this.description,
    required this.title,
    required this.notesDeleted,
  });
}
