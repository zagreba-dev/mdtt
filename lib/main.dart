import 'package:flutter/material.dart';
import 'package:mdtt/ui/contact_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Developer Test Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF986D8E)),
        useMaterial3: true,
      ),
      home: const ContactScreen(),
    );
  }
}
