import 'package:appnotes/controller/cubit/cubit_note/note_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../constant/hive_constant.dart';
import '../../../model/notes/notes_model.dart';
import '../app_cubit/app_cubit.dart';

class NoteCubit extends Cubit<NoteStates> {
  NoteCubit() : super(InitialStateNotes());
  static NoteCubit get(context) => BlocProvider.of(context);

  final Box _box = Hive.box(HiveConstants.noteBox);

  void addNote({
    required String title,
    required String description,
    required String date,
  }) {
    emit(LoadingAppAddState());
    try {
      List<NoteModel> notes = List.from(
        _box.get(
          HiveConstants.notesList,
          defaultValue: [],
        ),
      ).cast<NoteModel>();
      notes.add(NoteModel(
        date: date,
        description: description,
        title: title,
        index: notes.length,
      ));
      _box.put(HiveConstants.notesList, notes);

      emit(LoadedAppAddState(notes: notes));
    } catch (e) {
      emit(FailedAppAddState());
    }
  }

  void deleteNote({required int index}) {
    try {
      List<NoteModel> notes = List.from(
        _box.get(
          HiveConstants.notesList,
          defaultValue: [],
        ),
      ).cast<NoteModel>();
      AppCubit.notesDeleted.add(notes.removeAt(index));
      print(AppCubit.notesDeleted);
      for (int i = index; i < notes.length; i++) {
        notes[i] = notes[i].decrementIndex();
      }
      _box.put(HiveConstants.notesList, notes);
      emit(SuccessfulDeleteNoteState());
    } catch (e) {
      emit(FailedDeleteNoteState());
      print(e.toString());
    }
  }

  void getNotes() {
    emit(LoadingAppGetState());
    try {
      AppCubit.notesReturn = List.from(
        _box.get(
          HiveConstants.notesList,
          defaultValue: [],
        ),
      ).cast<NoteModel>();
      emit(LoadedAppGetState(notes: AppCubit.notesReturn));
    } catch (e) {
      emit(FailedAppGetState());
    }
  }
}
