import 'package:flutter/material.dart';
import 'screens/LoginScreen.dart'; // Import halaman login

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reg-On',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const LoginScreen(), // Mulai dari halaman login
    );
  }
}
