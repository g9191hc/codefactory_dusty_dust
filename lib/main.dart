import 'package:dusty_dust/screen/home_screen.dart';
import 'package:dusty_dust/screen/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

const testBox = 'test';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(testBox);

  runApp(
    MaterialApp(
      home: TestScreen(),
      // HomeScreen(),
      theme: ThemeData(
        fontFamily: 'sunflower',
      ),
    ),
  );
}
