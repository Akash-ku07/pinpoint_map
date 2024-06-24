import 'package:flutter/material.dart';
import 'package:hidayath_demo11/Pages/pinpoint_page.dart';
import 'package:hidayath_demo11/model/data_model.dart';
import 'package:hive_flutter/adapters.dart';

import 'Pages/camps_page.dart';

void main() {
  Hive.initFlutter();
  Hive.registerAdapter(DataModelAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:CampsPage(),
    );
  }
}