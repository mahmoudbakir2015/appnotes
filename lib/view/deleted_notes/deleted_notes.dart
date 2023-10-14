import 'package:appnotes/constant/color.dart';
import 'package:appnotes/controller/cubit/app_cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../controller/cubit/cubit_note_deleted/deleted_note_cubit.dart';
import '../../controller/cubit/cubit_note_deleted/deleted_note_states.dart';
import '../../shared/widget/note_card.dart';
import '../../shared/widget/sarch.dart';

// ignore: must_be_immutable
class Deleted extends StatefulWidget {
  final Box boxDelted;

  const Deleted({super.key, required this.boxDelted});

  @override
  State<Deleted> createState() => _DeletedState();
}

class _DeletedState extends State<Deleted> {
  @override
  void initState() {
    BlocProvider.of<DeletedCubit>(context).getDeletedNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Deleted",
          style: TextStyle(),
        ),
        leading: GestureDetector(
          onTap: () {
            AppCubit appCubit = AppCubit.get(context);
            Navigator.pop(context);
            appCubit.changeState();
          },
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Deleted",
              style: TextStyle(
                fontSize: 35,
                color: MyColors.secondaryColor,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SearchForm(),
            ),
            BlocBuilder<DeletedCubit, NoteDeletedStates>(
                builder: (context, state) {
              if (AppCubit.notesDeleted.isNotEmpty) {
                return Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NoteCard(
                        isNoteCard: false,
                        title: AppCubit.notesDeleted[index].title,
                        description: AppCubit.notesDeleted[index].description,
                        date: AppCubit.notesDeleted[index].date,
                        keyDismisable: AppCubit.notesDeleted.length,
                      );
                    },
                    itemCount: AppCubit.notesDeleted.length,
                  ),
                );
              } else {
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 100,
                  ),
                  child: Column(
                    children: [
                      CircularProgressIndicator(
                        color: MyColors.defaultColor,
                      ),
                      Text(
                        'error or no data deleted yet .....!!!',
                        style: TextStyle(
                          color: MyColors.defaultColor,
                        ),
                      ),
                    ],
                  ),
                ));
              }
            }),
          ],
        ),
      ),
    );
  }
}
