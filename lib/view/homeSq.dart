import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'addNote.dart';
import 'notes.dart';

class HomeSqf extends StatelessWidget {
  HomeSqf({super.key});
  late Box box;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Text(
              "Folders",
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
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "iDrive",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Notes(),
                      ),
                    );
                  },
                  child: const Card(
                    color: Color(0xFF1c1c1e),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.folder,
                              color: Color(0xFFd8b654),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Notes",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "5",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              child: SizedBox(
                height: 50,
                child: GestureDetector(
                  onTap: () {},
                  child: const Card(
                    color: Color(0xFF1c1c1e),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.delete_sharp,
                              color: Color(0xFFd8b654),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Deleted",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "5",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items: [
          BottomNavigationBarItem(
            label: "",
            icon: GestureDetector(
              onTap: () async {
                box = await Hive.openBox('notes');
                Hive.box('notes');
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
        ],
      ),
    );
  }
}
