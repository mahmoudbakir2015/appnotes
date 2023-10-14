import 'package:appnotes/constant/color.dart';
import 'package:appnotes/controller/cubit/app_cubit.dart';
import 'package:appnotes/shared/widget/floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../controller/cubit/app_states.dart';
import '../../shared/widget/bottom_app_bar.dart';
import '../../shared/widget/custom_note_card.dart';
import '../../shared/widget/note_card.dart';
import '../../shared/widget/sarch.dart';

// ignore: must_be_immutable
class NotePage extends StatefulWidget {
  final Box box;

  const NotePage({super.key, required this.box});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getNotes();
    super.initState();
  }

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
            BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
              AppCubit appCubit = AppCubit.get(context);

              if (state is LoadedAppGetState &&
                  appCubit.notesReturn.isNotEmpty) {
                return Expanded(
                  child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.notes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 15.0,
                      ),
                      itemBuilder: (context, index) {
                        return CustomNoteCard(
                          title: state.notes[index].title,
                          imageUrl: 'assets/images/note_1.png',
                          subtitle: state.notes[index].description,
                          keyDismisable: index,
                          date: state.notes[index].date,
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
                  //     return
                  // CustomNoteCard(
                  //       title: state.notes[index].title,
                  //       imageUrl: 'assets/images/note_1.jpg',
                  //       subtitle: state.notes[index].description,
                  //       keyDismisable: index,
                  //       date: state.notes[index].date,
                  //       onPressed: () {},
                  //     );
                  //     // NoteCard(
                  //     //   title: state.notes[index].title,
                  //     //   description: state.notes[index].description,
                  //     //   date: state.notes[index].date,
                  //     //   keyDismisable: index,
                  //     // );
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
        box: widget.box,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomBar(),
    );
  }
}
