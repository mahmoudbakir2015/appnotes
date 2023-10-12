class Note {
  final String title;
  final String description;
  final String date;
  List<Note> notesDeleted;
  Note({
    required this.date,
    required this.description,
    required this.title,
    required this.notesDeleted,
  });
}
