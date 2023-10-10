import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class AddNotes extends StatefulWidget {
  final Box box;
  const AddNotes({
    super.key,
    required this.box,
  });

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController headNote = TextEditingController();

  TextEditingController note = TextEditingController();

  TextEditingController date = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        leading: Row(
          children: [
            GestureDetector(
              onTap: () async {
                try {
                  if (formKey.currentState?.validate() != null) {
                    widget.box.addAll([
                      {
                        'headNote': headNote.text,
                        'note': note.text,
                        'date': date.text,
                      }
                    ]);
                    print(widget.box.get('headNote'));
                  } else {
                    Fluttertoast.showToast(
                      msg: "pls fill all field",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: const Color(0xFFd8b654),
                      textColor: const Color(0xFF1c1c1e),
                      fontSize: 16.0,
                    );
                  }
                } catch (e) {
                  Fluttertoast.showToast(
                      msg: e.toString(),
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: const Color(0xFFd8b654),
                      textColor: const Color(0xFF1c1c1e),
                      fontSize: 16.0);
                }
              },
              child: const Text("Done"),
            ),
            const Icon(
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
            child: const Row(
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
      backgroundColor: const Color(0xFF000000),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.black12,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      validator: (String? value) {
                        if (value != null) {
                          headNote.text = value;
                          setState(() {});
                        }
                        return 'This empty doesnot empty';
                      },
                      keyboardType: TextInputType.text,
                      controller: headNote,
                      maxLength: 20,
                      minLines: 1,
                      maxLines: 1,
                      decoration: const InputDecoration(
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
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      validator: (String? value) {
                        if (value != null) {
                          note.text = value;
                          setState(() {});
                        }
                        return 'This empty doesnot empty';
                      },
                      controller: note,
                      maxLength: 200,
                      minLines: 3,
                      maxLines: 20,
                      decoration: const InputDecoration(
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
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (String? value) {
                        if (value != null) {
                          date.text = value;
                          setState(() {});
                        }
                        return 'This empty doesnot empty';
                      },
                      keyboardType: TextInputType.datetime,
                      controller: date,
                      maxLength: 10,
                      minLines: 1,
                      maxLines: 1,
                      decoration: const InputDecoration(
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
      ),
    );
  }
}
