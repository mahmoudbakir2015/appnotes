// ignore_for_file: file_names

import 'package:appnotes/model/notes/notes.dart';
import 'package:appnotes/view/add_notes/items.dart';
import 'package:appnotes/view/home/home.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

// ignore: must_be_immutable
class AddNotes extends StatefulWidget {
  final Box box;
  const AddNotes({
    super.key,
    required this.box,
  });

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController headNote = TextEditingController();

  TextEditingController note = TextEditingController();

  TextEditingController date = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          "Add Notes",
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => Home(
                  box: widget.box,
                ),
              ),
              (route) => false,
            );
          },
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        actions: [
          const Icon(
            Icons.settings,
          ),
          const SizedBox(
            width: 10,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                try {
                  if (formKey.currentState?.validate() != null &&
                      (headNote.text != '' &&
                          note.text != '' &&
                          date.text != '')) {
                    notes = [];
                    notes.add(widget.box.add(
                      Note(
                          date: date.text,
                          description: note.text,
                          title: '',
                          notesDeleted: []),

                      //   {
                      //   'headNote': headNote.text,
                      //   'note': note.text,
                      //   'date': date.text,
                      // }
                    ));
                    print(note);
                  } else {
                    buildToast(error: "pls fill all field");

                    print("error");
                  }
                } catch (e) {
                  buildToast(error: e.toString());
                }
              },
              child: const Text("Done"),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.black12,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    CustomTextForm(
                      controller: headNote,
                      hintText: 'HeadNote',
                      icon: Icons.note_add_outlined,
                    ),
                    CustomTextForm(
                      isNote: true,
                      controller: note,
                      hintText: 'note',
                      icon: Icons.note_add,
                    ),
                    CustomTextForm(
                      controller: date,
                      hintText: 'date',
                      icon: Icons.date_range,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
