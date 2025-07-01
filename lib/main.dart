import 'package:calculator/shared/blocobserver.dart';
import 'package:flutter/material.dart';

import 'modules/counter.dart';



void main() {
  blocobserver: MyBlocObserver();

  //databaseFactory = databaseFactoryFfi;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      //home: HomeLayout(),
      home: CalculatorScreen(),
    );
  }
}
