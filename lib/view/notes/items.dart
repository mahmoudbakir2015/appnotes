// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appnotes/controller/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/color.dart';

// ignore: must_be_immutable
class NoteCard extends StatelessWidget {
  String title;
  String description;
  String date;
  int keyDismisable;
  NoteCard({
    Key? key,
    required this.title,
    required this.description,
    required this.date,
    required this.keyDismisable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
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
      onDismissed: ((direction) =>
          BlocProvider.of<AppCubit>(context).deleteNote(
            index: keyDismisable,
          )),
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
