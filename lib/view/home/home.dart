// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appnotes/controller/cubit/cubit_note_deleted/deleted_note_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'package:appnotes/constant/color.dart';
import 'package:appnotes/controller/cubit/app_cubit/app_cubit.dart';
import 'package:appnotes/controller/cubit/app_cubit/app_states.dart';
import 'package:appnotes/shared/widget/floating_button.dart';
import 'package:appnotes/shared/widget/sarch.dart';
import 'package:appnotes/view/deleted_notes/deleted_notes.dart';
import 'package:appnotes/view/home/items.dart';

import '../../controller/cubit/cubit_note/note_cubit.dart';
import '../../shared/widget/bottom_app_bar.dart';
import '../notes/notes.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  const Home({
    Key? key,
    required this.box,
    required this.boxDelted,
  }) : super(key: key);
  final Box box;
  final Box boxDelted;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    BlocProvider.of<NoteCubit>(context).getNotes();
    BlocProvider.of<DeletedCubit>(context).getDeletedNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Folders",
              style: TextStyle(
                fontSize: 35,
                color: MyColors.secondaryColor,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SearchForm(),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Folders",
                style: TextStyle(color: MyColors.secondaryColor),
              ),
            ),
            BlocConsumer<AppCubit, AppStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Folder(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NotePage(
                            box: widget.box,
                            boxDelted: widget.boxDelted,
                          ),
                        ),
                      );
                    },
                    name: 'Notes',
                    icon: Icons.folder,
                    counter: '${AppCubit.notesReturn.length}',
                  );
                }),
            BlocConsumer<AppCubit, AppStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Folder(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Deleted(
                            boxDelted: widget.boxDelted,
                          ),
                        ),
                      );
                    },
                    name: 'Deleted',
                    icon: Icons.delete,
                    counter: '${AppCubit.notesDeleted.length}',
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: buildFloatingButton(
        context: context,
        box: widget.box,
        boxDeleted: widget.boxDelted,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomBar(),
    );
  }
}
