import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class Test extends StatelessWidget {
  Test({super.key});
  late Box box;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              box = await Hive.openBox<String>('test');
            },
            child: const Text(
              'open box',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              box.put("name", 'mahmoud');
            },
            child: const Text(
              'put data',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print(box.get("name"));
            },
            child: const Text(
              'display data',
            ),
          ),
        ],
      ),
    );
  }
}
