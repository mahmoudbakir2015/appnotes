// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:appnotes/constant/color.dart';

// ignore: must_be_immutable
class Folder extends StatelessWidget {
  String name;
  IconData icon;
  String counter;
  void Function()? onTap;
  Folder({
    Key? key,
    required this.onTap,
    required this.name,
    required this.icon,
    required this.counter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      child: SizedBox(
        height: 50,
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            color: MyColors.fillColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: MyColors.defaultColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MyColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      counter,
                      style: const TextStyle(color: MyColors.thirdColor),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: MyColors.thirdColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
