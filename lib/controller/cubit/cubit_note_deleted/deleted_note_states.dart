import '../../../model/notes/notes_model.dart';

abstract class NoteDeletedStates {}

class InitilaStateNotes extends NoteDeletedStates {}

class LoadingAppAddDeletedState extends NoteDeletedStates {}

class LoadedAppAddDeletedState extends NoteDeletedStates {
  final List<NoteModel> notesDeleted;

  LoadedAppAddDeletedState({required this.notesDeleted});
}

class FailedAppAddDeletedState extends NoteDeletedStates {}

class LoadingDeleteNoteState extends NoteDeletedStates {}

class LoadingDeleteFromDeletePageNoteState extends NoteDeletedStates {}

class SuccessfulDeleteNoteFromDeletePageState extends NoteDeletedStates {}

class FailedDeleteNoteFromDeletePageState extends NoteDeletedStates {}

class ChangeState extends NoteDeletedStates {}

class LoadingAppDeletedState extends NoteDeletedStates {}

class LoadedAppDeletedState extends NoteDeletedStates {
  final List<NoteModel> deletedNotes;

  LoadedAppDeletedState({
    required this.deletedNotes,
  });
}

class FailedAppDeltedNotesState extends NoteDeletedStates {}
