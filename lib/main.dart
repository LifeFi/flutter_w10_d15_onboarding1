import 'package:flutter/material.dart';
import 'package:flutter_w10_d15_onboarding1/features/authentication/views/initial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF4A98E9),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const InitialScreen(),
    );
  }
}
