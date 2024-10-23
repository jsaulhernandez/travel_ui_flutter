import 'package:flutter/material.dart';
import 'package:travel_app/view/onboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Travel App',
      debugShowCheckedModeBanner: false,
      home: OnBoardPage(),
    );
  }
}
