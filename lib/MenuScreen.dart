// pachara bunjong 640510670 database
// chaiwitchit konfoo 640510609 & phichamon jongsukklang 640510625 design

import 'package:flutter/material.dart';
import 'games/snake_game.dart'; 

class MenuScreen extends StatefulWidget {
  final String username;
  const MenuScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to SnakeGamePage when Button A is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SnakeGamePage(username: widget.username)),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 100),
                textStyle: TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
                primary: Colors.purple.shade100, // Button A color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                      color:
                          Colors.purple.shade200), // Border color for 3D effect
                ),
                elevation: 5, // Add elevation for 3D effect
              ),
              child: Text('A'),
            ),
            SizedBox(height: 70), // Add some space between buttons
            ElevatedButton(
              onPressed: () {
                // Handle button B press
                print('Button B pressed');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 100),
                textStyle: TextStyle(fontSize: 100,  fontWeight: FontWeight.bold),
                primary: Colors.blue.shade100, // Button B color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      20.0), // Adjust the radius as needed
                  side: BorderSide(
                      color:
                          Colors.blue.shade200), // Border color for 3D effect
                ),
                elevation: 5, // Add elevation for 3D effect
              ),
              child: Text('B'),
            ),
          ],
        ),
      ),
    );
  }
}
