// LoginScreen.dart
import 'package:flutter/material.dart';
import 'package:artdirectory/main.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isUsernameAvailable(String username) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    return querySnapshot.docs.isEmpty;
  }

  Future<void> login() async {
    if (_usernameController.text.isNotEmpty) {
      bool isAvailable = await isUsernameAvailable(_usernameController.text);

      if (isAvailable) {
        // Username is available, proceed with your logic
        // For example, navigate to the HomeScreen
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const HomeScreen(title: "Art Directory")),
        );
      } else {
        // Handle the case where the username is not available
        print('Username is not available.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
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
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: login,
                  child: const Text('Login'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Generate a unique UUID for "Play as Guest"
                    String guestUuid = Uuid().v4();
                    _usernameController.text = 'user$guestUuid';

                    // You can navigate to the home screen or perform any other actions here
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const HomeScreen(title: "Art Directory")),
                    );
                  },
                  child: const Text('Play as Guest'),
                ),
              ],
            ),
          ),
        ],
    );
  }
}
