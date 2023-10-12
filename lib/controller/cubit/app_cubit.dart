import 'package:appnotes/controller/cubit/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../constant/hive_constant.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());
  static AppCubit get(context) => BlocProvider.of(context);

  final Box _box = Hive.box(HiveConstants.noteBox);
}
