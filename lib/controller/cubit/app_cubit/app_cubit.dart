import 'package:appnotes/controller/cubit/app_cubit/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import '../../../model/notes/notes_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());
  static AppCubit get(context) => BlocProvider.of(context);
  TextEditingController headNote = TextEditingController();

  TextEditingController note = TextEditingController();

  TextEditingController date = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static List<NoteModel> notesReturn = [];
  static List<NoteModel> notesDeleted = [];

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

  void changeState() {
    emit(ChangeState());
  }
}
