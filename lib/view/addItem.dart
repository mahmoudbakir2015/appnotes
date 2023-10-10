import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'homeSq.dart';
import 'package:appnotes/helper/sqflite.dart';

class SqfTest extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController count = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController parcode = TextEditingController();
  TextEditingController expire = TextEditingController();
  TextEditingController type = TextEditingController();
  SqfDb sqfDb = SqfDb();

  SqfTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("insertData"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("name"),
                ),
                keyboardType: TextInputType.name,
                controller: name,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("count"),
                ),
                keyboardType: TextInputType.number,
                controller: count,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("price"),
                ),
                keyboardType: TextInputType.number,
                controller: price,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("parcode"),
                ),
                keyboardType: TextInputType.number,
                controller: parcode,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("expire"),
                ),
                keyboardType: TextInputType.name,
                controller: expire,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("type"),
                ),
                keyboardType: TextInputType.name,
                controller: type,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    int response = await sqfDb.insertData('''
                  INSERT INTO 'medecine'(
                  'name','count','price','parcode','expire','type') 
                  VALUES(
                  '${name.text}',
                  '${count.text}',
                  '${price.text}',
                  '${parcode.text}',
                  '${expire.text}',
                  '${type.text}') 
                  ''');
                    print(response);
                    if (response.toInt() > 0) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => HomeSqf(),
                          ),
                          (route) => false);
                    }
                  } catch (e) {
                    Fluttertoast.showToast(
                        msg: "${e}",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                child: const Text("insertDate"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
