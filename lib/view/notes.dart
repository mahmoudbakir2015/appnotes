import 'package:appnotes/view/homeSq.dart';
import 'package:flutter/material.dart';
import 'package:appnotes/helper/sqflite.dart';
import 'package:hive/hive.dart';

import 'addNote.dart';

// ignore: must_be_immutable
class Notes extends StatelessWidget {
  late Box box;

  Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Notes",
            style: TextStyle(
              color: Color(0xFFd8b654),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF000000),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomeSqf(),
                ),
              );
            },
            child: const Row(
              children: [
                Text(
                  "folders",
                  style: TextStyle(
                    color: Color(0xFFd8b654),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFFd8b654),
                )
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const Text(
            "Notes",
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFF1c1c1e),
                hintText: "search",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          BottomNavigationBar(backgroundColor: Colors.black87, items: [
        BottomNavigationBarItem(
          label: "",
          icon: GestureDetector(
            onTap: () async {
              box = await Hive.openBox('notes');
              Hive.box('notes');
              // ignore: use_build_context_synchronously
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddNotes(
                    box: box,
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.edit_note,
              color: Color(0xFFd8b654),
            ),
          ),
        ),
        const BottomNavigationBarItem(
          label: "",
          icon: Icon(
            Icons.refresh,
            color: Color(0xFFd8b654),
          ),
        ),
      ]),
    );
  }
}
