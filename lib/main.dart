import 'package:flutter/material.dart';
import 'package:prayertimes/screens/Homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("starting ..........................");
    return MaterialApp(
      title: 'PrayerTimes',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Homepage(),
    );
  }
}
