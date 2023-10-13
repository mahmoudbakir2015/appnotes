import 'package:appnotes/constant/color.dart';
import 'package:flutter/material.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: MyColors.secondaryColor),
      decoration: const InputDecoration(
        label: Text(
          "search",
          style: TextStyle(
            color: MyColors.defaultColor,
          ),
        ),
        filled: true,
        fillColor: MyColors.fillColor,
        hintText: "search",
        hintStyle: TextStyle(
          color: MyColors.thirdColor,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: MyColors.defaultColor,
        ),
      ),
    );
  }
}
