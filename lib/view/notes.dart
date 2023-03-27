import 'package:appnotes/view/homeSq.dart';
import 'package:flutter/material.dart';
import 'package:appnotes/model/sqfliteData.dart';

import 'addNote.dart';

class Notes extends StatelessWidget {
  SqfDb sqfDb = SqfDb();

  Future<List<Map>> readData() async {
    List<Map> response = await sqfDb.readData("SELECT * FROM notes");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      appBar: AppBar(
        title: Center(
          child: Text(
            "Notes",
            style: TextStyle(
              color: Color(0xFFd8b654),
            ),
          ),
        ),
        backgroundColor: Color(0xFF000000),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomeSqf(),
                ),
              );
            },
            child: Row(
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
          Text(
            "Notes",
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
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
          Card(
            color: Color(0xFF1c1c1e),
            child: FutureBuilder(
              future: readData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Text(
                              "${snapshot.data![i]['headnote']}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${snapshot.data![i]['note']}",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "${snapshot.data![i]['date']}",
                                      style: TextStyle(
                                        color: Colors.greenAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                              height: 1,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Center(
                    child: Text(
                      "Corrupted data or empty notes add new note",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          BottomNavigationBar(backgroundColor: Colors.black87, items: [
        BottomNavigationBarItem(
          label: "",
          icon: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddNotes(),
                ),
              );
            },
            child: Icon(
              Icons.edit_note,
              color: Color(0xFFd8b654),
            ),
          ),
        ),
        BottomNavigationBarItem(
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
