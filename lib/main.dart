// pachara bunjong 640510670 

// main.dart
import 'package:flutter/material.dart';
import 'LoginScreen.dart';   // Import LoginScreen
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Art Directory'),
        backgroundColor: Colors.white,
      ),
      body: const LoginScreen(username: '', score1: 0, score2: 0),  // Provide default values for username, score1, and score2
    );
  }
}
