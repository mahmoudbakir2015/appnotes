// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appnotes/constant/color.dart';
import 'package:appnotes/controller/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class CustomTextForm extends StatefulWidget {
  TextEditingController controller;
  String hintText;
  IconData icon;
  bool isNote;
  bool isDate;
  CustomTextForm({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.isNote = false,
    this.isDate = false,
  }) : super(key: key);

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  @override
  Widget build(BuildContext context) {
    AppCubit appCubit = AppCubit.get(context);
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      child: TextFormField(
        readOnly: widget.isDate ? true : false,
        onTap: () {
          if (widget.isDate == true) {
            appCubit.getTimePicker(context: context);
          }
        },
        keyboardType: TextInputType.multiline,
        // ignore: body_might_complete_normally_nullable
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'This empty doesn\'t empty';
          } else {
            widget.controller.text = value;
            setState(() {});
          }
        },
        controller: widget.controller,
        style: const TextStyle(color: MyColors.secondaryColor),
        maxLength: widget.isNote ? 200 : 50,
        minLines: 1,
        maxLines: 20,
        decoration: InputDecoration(
          filled: true,
          label: Text(
            widget.hintText,
            style: const TextStyle(
              color: MyColors.defaultColor,
            ),
          ),
          fillColor: MyColors.fillColor,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: MyColors.thirdColor,
          ),
          prefixIcon: Icon(
            widget.icon,
            color: MyColors.defaultColor,
          ),
        ),
      ),
    );
  }
}

buildToast({required String error}) {
  return Fluttertoast.showToast(
    msg: error.toString(),
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: MyColors.defaultColor,
    textColor: MyColors.secondaryColor,
    fontSize: 16.0,
  );
}
