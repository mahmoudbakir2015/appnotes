import 'package:appnotes/constant/color.dart';
import 'package:appnotes/constant/hive_constant.dart';
import 'package:appnotes/controller/cubit/app_cubit/app_cubit.dart';
import 'package:appnotes/controller/cubit/cubit_note/note_cubit.dart';
import 'package:appnotes/controller/cubit/cubit_note_deleted/deleted_note_cubit.dart';
import 'package:appnotes/model/notes/notes_adapter.dart';
import 'package:appnotes/shared/bloc_observer.dart';
import 'package:appnotes/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding();

  await Hive.initFlutter();
  Hive.registerAdapter(NotesAdapter());
  Bloc.observer = MyBlocObserver();
  Box box = await Hive.openBox(HiveConstants.noteBox);
  Box boxDeleted = await Hive.openBox(HiveConstants.noteBoxDeleted);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => DeletedCubit(),
        ),
        BlocProvider(
          create: (context) => NoteCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: MyColors.backgroundColor,
            appBarTheme: const AppBarTheme(
              titleSpacing: 0,
              titleTextStyle: TextStyle(color: MyColors.defaultColor),
              backgroundColor: MyColors.backgroundColor,
              iconTheme: IconThemeData(
                color: MyColors.defaultColor,
              ),
            )),
        debugShowCheckedModeBanner: false,
        home: Home(
          box: box,
          boxDelted: boxDeleted,
        ),
      ),
    ),
  );
}
