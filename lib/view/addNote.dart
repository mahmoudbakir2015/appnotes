import 'package:flutter/material.dart';
import 'package:appnotes/model/sqfliteData.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNotes extends StatefulWidget {
  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController headNote = TextEditingController();

  TextEditingController note = TextEditingController();

  TextEditingController date = TextEditingController();

  SqfDb sqfDb = SqfDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF000000),
        leading: Row(
          children: [
            GestureDetector(
              onTap: () async {
                try {
                  if (headNote.text == "" &&
                      note.text == "" &&
                      date.text == "") {
                    Fluttertoast.showToast(
                        msg: "pls fill all field",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color(0xFFd8b654),
                        textColor: Color(0xFF1c1c1e),
                        fontSize: 16.0);
                  } else {
                    int response = await sqfDb.insertData('''
                  INSERT INTO 'notes'(
                  'headnote','note','date') 
                  VALUES(
                  '${headNote.text}',
                  '${note.text}',
                  '${date.text}'
                  ) 
                  ''');
                    print(response);
                    if (response.toInt() > 0) {
                      setState(() {
                        headNote.text = "";
                        note.text = "";
                        date.text = "";
                      });
                    }
                  }
                } catch (e) {
                  Fluttertoast.showToast(
                      msg: "${e}",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Color(0xFFd8b654),
                      textColor: Color(0xFF1c1c1e),
                      fontSize: 16.0);
                }
              },
              child: Text("Done"),
            ),
            SizedBox(
              width: 1,
            ),
            Icon(
              Icons.settings,
              color: Color(0xFFd8b654),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Text(
                  "Notes",
                  style: TextStyle(
                    color: Color(0xFFd8b654),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFFd8b654),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFF000000),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.black12,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(keyboardType: TextInputType.text,
                    controller: headNote,
                    maxLength: 20,
                    minLines: 1,
                    maxLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1c1c1e),
                      hintText: "HeadNote",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      prefixIcon: Icon(
                        Icons.add,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(keyboardType: TextInputType.multiline,
                    controller: note,
                    maxLength: 200,
                    minLines: 3,
                    maxLines: 20,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1c1c1e),
                      hintText: "Note",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      prefixIcon: Icon(
                        Icons.add,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    controller: date,
                    maxLength: 10,
                    minLines: 1,
                    maxLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1c1c1e),
                      hintText: "Date",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      prefixIcon: Icon(
                        Icons.add,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
