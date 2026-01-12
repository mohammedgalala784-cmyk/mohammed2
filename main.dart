import 'package:flutter/material.dart';
import 'home.dart'; // إذا كان الكود في ملف home.dart
import 'splas.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(), // هذه هي الصفحة الرئيسية الوحيدة
    );
  }
}