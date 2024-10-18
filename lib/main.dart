import 'package:flutter/material.dart';
import 'package:manajemenpariwisata/ui/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manajemen Pariwisata',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Arial',
        brightness: Brightness.light,
      ),
      home: LoginScreen(),
    );
  }
}
