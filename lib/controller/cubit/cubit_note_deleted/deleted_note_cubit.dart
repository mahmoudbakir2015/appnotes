import 'package:appnotes/controller/cubit/cubit_note_deleted/deleted_note_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../constant/hive_constant.dart';
import '../../../model/notes/notes_model.dart';
import '../app_cubit/app_cubit.dart';

class DeletedCubit extends Cubit<NoteDeletedStates> {
  DeletedCubit() : super(InitilaStateNotes());
  static DeletedCubit get(context) => BlocProvider.of(context);

  final Box _boxNoteDeleted = Hive.box(HiveConstants.noteBoxDeleted);
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
      _boxNoteDeleted.put(HiveConstants.notesDeletedList, notes);

      emit(LoadedAppAddDeletedState(notesDeleted: notes));
    } catch (e) {
      emit(FailedAppAddDeletedState());
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
      _boxNoteDeleted.put(HiveConstants.notesDeletedList, notes);
      emit(SuccessfulDeleteNoteFromDeletePageState());
    } catch (e) {
      emit(FailedDeleteNoteFromDeletePageState());
      print(e.toString());
    }
  }

  void getDeletedNotes() {
    emit(LoadingAppDeletedState());
    try {
      AppCubit.notesDeleted = List.from(
        _boxNoteDeleted.get(
          HiveConstants.notesDeletedList,
          defaultValue: [],
        ),
      ).cast<NoteModel>();
      print(AppCubit.notesDeleted);
      emit(LoadedAppDeletedState(
        deletedNotes: AppCubit.notesDeleted,
      ));
    } catch (e) {
      emit(FailedAppDeltedNotesState());
    }
  }
}
