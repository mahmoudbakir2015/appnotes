import 'package:appnotes/constant/color.dart';
import 'package:appnotes/shared/floating_button.dart';
import 'package:appnotes/shared/sarch.dart';
import 'package:appnotes/view/deleted_notes/deleted_notes.dart';
import 'package:appnotes/view/home/items.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../shared/bottom_app_bar.dart';
import '../notes/notes.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  const Home({super.key, required this.box});
  final Box box;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Text(
              "Folders",
              style: TextStyle(
                fontSize: 35,
                color: MyColors.secondaryColor,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SearchForm(),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Folders",
                style: TextStyle(color: MyColors.secondaryColor),
              ),
            ),
            Folder(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Notes(
                      box: box,
                    ),
                  ),
                );
              },
              name: 'Notes',
              icon: Icons.folder,
              counter: '10',
            ),
            Folder(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Deleted(
                      box: box,
                    ),
                  ),
                );
              },
              name: 'Deleted',
              icon: Icons.delete,
              counter: '10',
            ),
          ],
        ),
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
