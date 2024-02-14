import 'package:artdirectory/main.dart';
import 'package:flutter/material.dart';
import 'MenuScreen.dart';
import 'CameraScreen.dart';
import 'RankingScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const MenuScreen(),
    const CameraScreen(),
    const RankingScreen(),
  ];

  // Function to handle logout
  void _logout() {
  // Navigate back to the login screen and replace the current route
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const MainScreen()),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Art Directory'),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: _logout, // Call the logout function
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: const [0.05, 0.25, 0.55, 0.825, 0.95],
            colors: [
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
