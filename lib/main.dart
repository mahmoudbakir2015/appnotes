import 'package:appnotes/constant/color.dart';
import 'package:appnotes/model/notes/notes_adapter.dart';
import 'package:appnotes/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding();
  await Hive.initFlutter();
  Box box = await Hive.openBox('notes');
  Hive.registerAdapter(NotesAdapter());
  runApp(
    MaterialApp(
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
      ),
    ),
  );
}
