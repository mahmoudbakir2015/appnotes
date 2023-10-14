// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

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
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding();

  await Hive.initFlutter();
  Hive.registerAdapter(NotesAdapter());
  Bloc.observer = MyBlocObserver();
  Box box = await Hive.openBox(HiveConstants.noteBox);
  Box boxDeleted = await Hive.openBox(HiveConstants.noteBoxDeleted);
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MultiBlocProvider(
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
    )
        // Home(
        //   box: box, boxDelted: null,
        // ),
        );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
