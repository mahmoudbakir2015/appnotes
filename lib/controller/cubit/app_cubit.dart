import 'package:appnotes/controller/cubit/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../constant/hive_constant.dart';
import '../../model/notes/notes.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());
  static AppCubit get(context) => BlocProvider.of(context);

  final Box _box = Hive.box(HiveConstants.noteBox);
  List<Note> notesReturn = [];

  void addNote({
    required String title,
    required String description,
    required String date,
  }) {
    emit(LoadingAppAddState());
    try {
      List<Note> notes = List.from(
        _box.get(
          HiveConstants.notesList,
          defaultValue: [],
        ),
      ).cast<Note>();
      notes.add(Note(
        date: date,
        description: description,
        title: title,
        notesDeleted: [],
        index: notes.length,
      ));
      _box.put(HiveConstants.notesList, notes);
      print(notes[notes.length - 1].date);
      emit(LoadedAppAddState(notes: notes));
    } catch (e) {
      emit(FailedAppAddState());
    }
  }

  void getNotes() {
    emit(LoadingAppGetState());
    try {
      notesReturn = List.from(
        _box.get(
          HiveConstants.notesList,
          defaultValue: [],
        ),
      ).cast<Note>();
      emit(LoadedAppGetState(notes: notesReturn));
    } catch (e) {
      emit(FailedAppGetState());
    }
  }

  void deleteNote({required int index}) {
    emit(LoadingDeleteNoteState());
    try {
      List<Note> notes = List.from(
        _box.get(
          HiveConstants.notesList,
          defaultValue: [],
        ),
      ).cast<Note>();
      notes.removeAt(index);
      for (int i = index; i < notes.length; i++) {
        notes[i] = notes[i].decrementIndex();
      }
      _box.put(HiveConstants.notesList, notes);
      emit(SuccessfulDeleteNoteState());
    } catch (e) {
      emit(FailedDeleteNoteState());
    }
  }
}
