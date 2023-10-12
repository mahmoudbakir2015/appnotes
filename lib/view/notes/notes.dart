import 'package:appnotes/constant/color.dart';
import 'package:appnotes/shared/floating_button.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../shared/bottom_app_bar.dart';
import '../../shared/sarch.dart';

// ignore: must_be_immutable
class Notes extends StatelessWidget {
  final Box box;

  const Notes({super.key, required this.box});

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
      body: Column(
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
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.red,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: buildFloatingButton(
        context: context,
        box: box,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomBar(),
    );
  }
}
