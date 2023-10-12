import 'package:appnotes/constant/color.dart';
import 'package:flutter/material.dart';

buildBottomBar() {
  return BottomAppBar(
    shape: const CircularNotchedRectangle(),
    child: Container(
      height: 50,
      color: MyColors.fillColor,
    ),
  );
}
