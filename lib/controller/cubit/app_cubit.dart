import 'package:appnotes/controller/cubit/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:hive/hive.dart';

import '../../constant/hive_constant.dart';
import '../../model/notes/notes_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());
  static AppCubit get(context) => BlocProvider.of(context);
  TextEditingController headNote = TextEditingController();

  TextEditingController note = TextEditingController();

  TextEditingController date = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Box _box = Hive.box(HiveConstants.noteBox);
  final Box _boxNoteDeleted = Hive.box(HiveConstants.noteBoxDeleted);

  List<NoteModel> notesReturn = [];
  List<NoteModel> notesDeleted = [];

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
      print(notes[notes.length - 1].date);
      emit(LoadedAppAddState(notes: notes));
    } catch (e) {
      emit(FailedAppAddState());
    }
  }

  void addNoteDeleted({
    required String title,
    required String description,
    required String date,
  }) {
    emit(LoadingAppAddDeletedState());
    try {
      List<NoteModel> notes = List.from(
        _boxNoteDeleted.get(
          HiveConstants.notesDeletedList,
          defaultValue: [],
        ),
      ).cast<NoteModel>();
      notes.add(NoteModel(
        date: date,
        description: description,
        title: title,
        index: notes.length,
      ));
      _box.put(HiveConstants.notesDeletedList, notes);
      print(notes[notes.length - 1].date);
      emit(LoadedAppAddDeletedState(notesDeleted: notes));
    } catch (e) {
      emit(FailedAppAddDeletedState());
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
      ).cast<NoteModel>();
      emit(LoadedAppGetState(notes: notesReturn));
    } catch (e) {
      emit(FailedAppGetState());
    }
  }

  void getDeletedNotes() {
    emit(LoadingAppDeletedState());
    try {
      notesDeleted = List.from(
        _box.get(
          HiveConstants.notesDeletedList,
          defaultValue: [],
        ),
      ).cast<NoteModel>();
      emit(LoadedAppDeletedState(
        deletedNotes: notesDeleted,
      ));
    } catch (e) {
      emit(FailedAppDeltedNotesState());
    }
  }

  void deleteNote({required int index}) {
    emit(LoadingDeleteNoteState());
    try {
      List<NoteModel> notes = List.from(
        _box.get(
          HiveConstants.notesList,
          defaultValue: [],
        ),
      ).cast<NoteModel>();
      notesDeleted.add(notes.removeAt(index));
      print(notesDeleted);
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

  void deleteNoteFromDeletePage({required int index}) {
    emit(LoadingDeleteFromDeletePageNoteState());
    try {
      List<NoteModel> notes = List.from(
        _boxNoteDeleted.get(
          HiveConstants.notesDeletedList,
          defaultValue: [],
        ),
      ).cast<NoteModel>();

      for (int i = index; i < notes.length; i++) {
        notes[i] = notes[i].decrementIndex();
      }
      _box.put(HiveConstants.notesDeletedList, notes);
      emit(SuccessfulDeleteNoteFromDeletePageState());
    } catch (e) {
      emit(FailedDeleteNoteFromDeletePageState());
      print(e.toString());
    }
  }

  void getTimePicker({required BuildContext context}) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(2030, 6, 7),
      onChanged: (time) {
        date.text = time.toString().characters.take(10).toString();
      },
      onConfirm: (time) {
        date.text = time.toString().characters.take(10).toString();
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }
}
