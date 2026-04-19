import 'package:flutter/material.dart';
import 'presentation/screens/trash_classify_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: const Color(0xFF0B1020),
      ),
      home: const TrashClassifyScreen(),
    );
  }
}
