import 'package:appnotes/constant/color.dart';
import 'package:appnotes/controller/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../controller/cubit/app_states.dart';
import '../../shared/widget/note_card.dart';
import '../../shared/widget/sarch.dart';

// ignore: must_be_immutable
class Deleted extends StatefulWidget {
  final Box box;

  const Deleted({super.key, required this.box});

  @override
  State<Deleted> createState() => _DeletedState();
}

class _DeletedState extends State<Deleted> {
  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getDeletedNotes();
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
            Navigator.pop(context);
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
            BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
              AppCubit appCubit = AppCubit.get(context);

              if (state is LoadedAppDeletedState &&
                  appCubit.notesDeleted.isNotEmpty) {
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
                        title: state.deletedNotes[index].title,
                        description: state.deletedNotes[index].description,
                        date: state.deletedNotes[index].date,
                        keyDismisable: index,
                      );
                    },
                    itemCount: state.deletedNotes.length,
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
