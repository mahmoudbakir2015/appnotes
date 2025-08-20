// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'package:appnotes/controller/cubit/app_cubit/app_cubit.dart';
import 'package:appnotes/view/add_notes/items.dart';
import 'package:appnotes/view/home/home.dart';

import '../../controller/cubit/cubit_note/note_cubit.dart';

// ignore: must_be_immutable
class AddNotes extends StatefulWidget {
  final Box box;
  final Box boxDeleted;
  const AddNotes({
    Key? key,
    required this.box,
    required this.boxDeleted,
  }) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  @override
  Widget build(BuildContext context) {
    AppCubit appCubit = AppCubit.get(context);
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
                  boxDelted: widget.boxDeleted,
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
          const SizedBox(
            width: 10,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                try {
                  if (appCubit.formKey.currentState?.validate() != null &&
                      (appCubit.headNote.text != '' &&
                          appCubit.note.text != '' &&
                          appCubit.date.text != '')) {
                    BlocProvider.of<NoteCubit>(context).addNote(
                      title: appCubit.headNote.text,
                      description: appCubit.note.text,
                      date: appCubit.date.text,
                    );

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => Home(
                                  box: widget.box,
                                  boxDelted: widget.boxDeleted,
                                )),
                        (route) => false);
                    appCubit.changeState();
                  } else {
                    buildToast(error: "pls fill all field");

                    print("error");
                  }
                } catch (e) {
                  buildToast(error: e.toString());
                }
              },
              child: const Text(
                "Done",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: appCubit.formKey,
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
                        controller: appCubit.headNote,
                        hintText: 'HeadNote',
                        icon: Icons.note_add_outlined,
                      ),
                      CustomTextForm(
                        isNote: true,
                        controller: appCubit.note,
                        hintText: 'note',
                        icon: Icons.note_add,
                      ),
                      CustomTextForm(
                        isDate: true,
                        controller: appCubit.date,
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
      ),
    );
  }
}
