import 'package:appnotes/model/notes/notes_adapter.dart';
import 'package:appnotes/view/homeSq.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding();
  await Hive.initFlutter();
  Hive.registerAdapter(NotesAdapter());
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeSqf(),
    ),
  );
}
