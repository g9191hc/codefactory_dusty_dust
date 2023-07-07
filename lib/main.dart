import 'package:dusty_dust/screen/home_screen.dart';
import 'package:dusty_dust/screen/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'model/stat_model.dart';

const testBox = 'test';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter<StatModel>(StatModelAdapter());
  Hive.registerAdapter<ItemCode>(ItemCodeAdapter());

  for (ItemCode itemCode in ItemCode.values) {
    await Hive.openBox<StatModel>(itemCode.name);
  }

  await Hive.openBox(testBox);

  runApp(
    MaterialApp(
      home:
          // TestScreen(),
          HomeScreen(),
      theme: ThemeData(
        fontFamily: 'sunflower',
      ),
    ),
  );
}
