import '../../model/notes/notes.dart';

abstract class AppStates {}

class InitialAppState extends AppStates {}

class LoadingAppGetState extends AppStates {}

class LoadedAppGetState extends AppStates {
  final List<Note> notes;

  LoadedAppGetState({required this.notes});
}

class FailedAppGetState extends AppStates {}

class LoadingAppAddState extends AppStates {}

class LoadedAppAddState extends AppStates {
  final List<Note> notes;

  LoadedAppAddState({required this.notes});
}

class FailedAppAddState extends AppStates {}

class LoadingAppAddDeletedState extends AppStates {}

class LoadedAppAddDeletedState extends AppStates {
  final List<Note> notesDeleted;

  LoadedAppAddDeletedState({required this.notesDeleted});
}

class FailedAppAddDeletedState extends AppStates {}

class LoadingDeleteNoteState extends AppStates {}

class SuccessfulDeleteNoteState extends AppStates {}

class FailedDeleteNoteState extends AppStates {}

class LoadingDeleteFromDeletePageNoteState extends AppStates {}

class SuccessfulDeleteNoteFromDeletePageState extends AppStates {}

class FailedDeleteNoteFromDeletePageState extends AppStates {}

class ChangeState extends AppStates {}

class LoadingAppDeletedState extends AppStates {}

class LoadedAppDeletedState extends AppStates {
  final List<Note> deletedNotes;

  LoadedAppDeletedState({
    required this.deletedNotes,
  });
}

class FailedAppDeltedNotesState extends AppStates {}
