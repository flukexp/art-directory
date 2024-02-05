import 'package:flutter/material.dart';
import 'package:artdirectory/main.dart';
import 'package:uuid/uuid.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Art Directory'),
        backgroundColor: Colors.white,
      ),
      body: Stack(
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
                  onPressed: () {
                    // Add your login logic here
                    // For simplicity, let's navigate to the HomeScreen if username and password are not empty
                    if (_usernameController.text.isNotEmpty) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MyHomePage(title: "Art Directory")),
                      );
                    }
                  },
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
                      MaterialPageRoute(builder: (context) => const MyHomePage(title: "Art Directory")),
                    );
                  },
                  child: const Text('Play as Guest'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
