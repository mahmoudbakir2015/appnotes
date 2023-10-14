class NoteModel {
  int index;
  String title;
  String description;
  String date;
  NoteModel({
    required this.index,
    required this.date,
    required this.description,
    required this.title,
  });

  NoteModel decrementIndex() {
    return NoteModel(
      index: index - 1,
      date: date,
      description: description,
      title: title,
    );
  }
}
