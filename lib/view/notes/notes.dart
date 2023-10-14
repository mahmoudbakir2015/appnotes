import 'package:appnotes/constant/color.dart';
import 'package:appnotes/controller/cubit/app_cubit/app_cubit.dart';
import 'package:appnotes/shared/widget/floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../controller/cubit/cubit_note/note_cubit.dart';
import '../../controller/cubit/cubit_note/note_states.dart';
import '../../controller/cubit/cubit_note_deleted/deleted_note_states.dart';
import '../../shared/widget/bottom_app_bar.dart';
import '../../shared/widget/custom_note_card.dart';
import '../../shared/widget/sarch.dart';

// ignore: must_be_immutable
class NotePage extends StatelessWidget {
  final Box box;
  final Box boxDelted;

  const NotePage({super.key, required this.box, required this.boxDelted});

  @override
//   State<NotePage> createState() => _NotePageState();
// }

// class _NotePageState extends State<NotePage> {
//   @override
//   void initState() {
//     BlocProvider.of<NoteCubit>(context).getNotes();
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes",
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
              "Notes",
              style: TextStyle(
                fontSize: 35,
                color: MyColors.secondaryColor,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SearchForm(),
            ),
            BlocBuilder<NoteCubit, NoteStates>(builder: (context, state) {
              if (AppCubit.notesReturn.isNotEmpty) {
                return Expanded(
                  child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: AppCubit.notesReturn.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemBuilder: (context, index) {
                        return CustomNoteCard(
                          title: AppCubit.notesReturn[index].title,
                          imageUrl: 'assets/images/note_1.png',
                          subtitle: AppCubit.notesReturn[index].description,
                          keyDismisable: AppCubit.notesReturn.length,
                          date: AppCubit.notesReturn[index].date,
                          onPressed: () {},
                        );
                      }),
                  // ListView.separated(
                  //   shrinkWrap: true,
                  //   separatorBuilder: (context, index) => const SizedBox(
                  //     height: 5,
                  //   ),
                  //   physics: const BouncingScrollPhysics(),
                  //   itemBuilder: (context, index) {
                  //     return NoteCard(
                  //       title: state.notes[index].title,
                  //       description: state.notes[index].description,
                  //       date: state.notes[index].date,
                  //       keyDismisable: index,
                  //     );
                  //   },
                  //   itemCount: state.notes.length,
                  // ),
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
                        'error or no data .....!!!',
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
      floatingActionButton: buildFloatingButton(
        context: context,
        box: box,
        boxDeleted: boxDelted,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomBar(),
    );
  }
}
