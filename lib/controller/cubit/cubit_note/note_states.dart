import '../../../model/notes/notes_model.dart';

abstract class NoteStates {}

class InitialStateNotes extends NoteStates {}

class LoadingAppGetState extends NoteStates {}

class LoadedAppGetState extends NoteStates {
  final List<NoteModel> notes;

  LoadedAppGetState({required this.notes});
}

class FailedAppGetState extends NoteStates {}

class LoadingAppAddState extends NoteStates {}

class LoadedAppAddState extends NoteStates {
  final List<NoteModel> notes;

  LoadedAppAddState({required this.notes});
}

class FailedAppAddState extends NoteStates {}

class LoadingAppAddDeletedState extends NoteStates {}

class SuccessfulDeleteNoteState extends NoteStates {}

class FailedDeleteNoteState extends NoteStates {}
