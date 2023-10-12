import 'package:appnotes/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../shared/sarch.dart';

// ignore: must_be_immutable
class Deleted extends StatelessWidget {
  final Box box;

  const Deleted({super.key, required this.box});

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
      body: ListView(
        children: const [
          Text(
            "Deleted",
            style: TextStyle(
              fontSize: 35,
              color: MyColors.secondaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SearchForm(),
          ),
        ],
      ),
    );
  }
}
