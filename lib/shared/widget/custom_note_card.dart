// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appnotes/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/cubit/cubit_note/note_cubit.dart';
import '../../controller/cubit/cubit_note_deleted/deleted_note_cubit.dart';

// ignore: must_be_immutable
class CustomNoteCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String subtitle;
  bool isNoteCard;
  int keyDismisable;
  String date;
  final Function() onPressed;

  CustomNoteCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.subtitle,
    this.isNoteCard = true,
    required this.keyDismisable,
    required this.date,
    required this.onPressed,
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
          BlocProvider.of<NoteCubit>(context).deleteNote(
            index: keyDismisable,
          );
          BlocProvider.of<DeletedCubit>(context).addNoteDeleted(
            title: title,
            description: subtitle,
            date: date,
          );
        }
        if (isNoteCard == true) {
          if (DismissDirection.startToEnd == direction) {
            BlocProvider.of<DeletedCubit>(context)
                .deleteNoteFromDeletePage(index: keyDismisable);
          } else {
            BlocProvider.of<NoteCubit>(context).addNote(
              title: title,
              description: subtitle,
              date: date,
            );
            BlocProvider.of<DeletedCubit>(context)
                .deleteNoteFromDeletePage(index: keyDismisable);
          }
        }
      }),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: MyColors.fillColor,
            borderRadius: BorderRadius.circular(12.5),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(10, 20),
                  blurRadius: 10,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.05)),
            ],
          ),
          child: Column(
            children: [
              Image.asset(imageUrl, height: 100, fit: BoxFit.cover),
              const Spacer(),
              Text(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
              const SizedBox(
                height: 5,
              ),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 12),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                date,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
