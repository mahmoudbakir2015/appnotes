// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:appnotes/controller/cubit/app_cubit.dart';

import '../../constant/color.dart';

// ignore: must_be_immutable
class NoteCard extends StatelessWidget {
  String title;
  String description;
  String date;
  bool isNoteCard;
  int keyDismisable;
  NoteCard({
    Key? key,
    required this.title,
    required this.description,
    required this.date,
    this.isNoteCard = true,
    required this.keyDismisable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      secondaryBackground: !isNoteCard
          ? Container(
              color: Colors.green,
              padding: const EdgeInsets.only(left: 20.0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.add,
                  )
                ],
              ),
            )
          : null,
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.only(left: 20.0),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.delete,
            )
          ],
        ),
      ),
      key: Key('$keyDismisable'),
      onDismissed: ((direction) {
        if (isNoteCard == true) {
          BlocProvider.of<AppCubit>(context).deleteNote(
            index: keyDismisable,
          );
          BlocProvider.of<AppCubit>(context).addNoteDeleted(
            title: title,
            description: description,
            date: date,
          );
        } else {
          if (DismissDirection.startToEnd == direction) {
            BlocProvider.of<AppCubit>(context)
                .deleteNoteFromDeletePage(index: keyDismisable);
          } else {
            BlocProvider.of<AppCubit>(context).addNote(
              title: title,
              description: description,
              date: date,
            );
            BlocProvider.of<AppCubit>(context)
                .deleteNoteFromDeletePage(index: keyDismisable);
          }
        }
      }),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: MyColors.defaultColor,
          child: Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                color: MyColors.fillColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: MyColors.secondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          description,
                          maxLines: 2,
                          style: const TextStyle(
                            color: MyColors.thirdColor,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ]),
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
