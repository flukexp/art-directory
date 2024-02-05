import 'package:artdirectory/CameraScreen.dart';
import 'package:artdirectory/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:artdirectory/RankingScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Art-Directory'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomeScreen(),
    const CameraScreen(),
    const RankingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Art Directory'),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        // Add box decoration
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: const [0.05, 0.25, 0.55, 0.825, 0.95],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Colors.red.shade100,
              Colors.white,
              Colors.blue.shade100,
              Colors.white,
              Colors.red.shade100,
            ],
          ),
        ),
        child: _tabs[_currentIndex],
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Camera',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Ranking',
            ),
          ],
        ),
      ),
    );
  }
}
