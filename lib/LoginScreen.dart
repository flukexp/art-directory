// LoginScreen.dart
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  final String username;
  final int score1;
  final int score2;
  const LoginScreen({
    Key? key,
    required this.username,
    required this.score1,
    required this.score2,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<bool> isUsernameAvailable(String username) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where(FieldPath.documentId, isEqualTo: username)
        .get();

    return querySnapshot.docs.isEmpty;
  }

  void showUsernameNotAvailableDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Username Not Available'),
        content: Text('The username you entered is already in use. Please choose a different one.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

  Future<void> login() async {
    if (_usernameController.text.isNotEmpty) {
      bool isAvailable = await isUsernameAvailable(_usernameController.text);

      if (isAvailable) {
        // Create a reference to a user document using the unique username
        DocumentReference userRef = users.doc(_usernameController.text);

        // Set the data for the user document
        userRef
            .set({
              'score1': 0,
              'score2': 0
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(title: "Art Directory", username: _usernameController.text)),
        );
      } else {
        print('Username is not available.');
        showUsernameNotAvailableDialog(context);
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
                  String guestUuid = Uuid().v4();
                  String shortUuid = guestUuid.substring(0, 5); // Extracting the first 5 characters
                  _usernameController.text = 'user$shortUuid';

                  login(); // Removed unnecessary closing parenthesis here
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
