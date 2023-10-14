import 'package:appnotes/constant/color.dart';
import 'package:appnotes/view/add_notes/addNote.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

buildFloatingButton(
    {required BuildContext context,
    required Box box,
    required Box boxDeleted}) {
  return FloatingActionButton(
    backgroundColor: MyColors.defaultColor,
    mini: false,
    onPressed: () async {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddNotes(
            box: box,
            boxDeleted: boxDeleted,
          ),
        ),
      );
    },
    child: const Icon(
      Icons.edit_note,
      color: MyColors.secondaryColor,
    ),
  );
}
