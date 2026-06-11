import 'package:flutter/material.dart';
import 'screens/communityPage.dart';
import 'screens/newEvent.dart';
import 'screens/announcementPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(themeMode: ThemeMode.dark, home: Announcementpage());
  }
}
