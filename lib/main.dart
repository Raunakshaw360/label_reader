import 'package:flutter/material.dart';
import 'package:label_scan/screens/home_screen.dart';
import 'package:label_scan/screens/news_screen.dart';
//lets start

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/news': (context) =>  NewsScreen(),
      },
    );
  }
}
