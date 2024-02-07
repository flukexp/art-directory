import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

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
                // Handle button A press
                print('Button A pressed');
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
