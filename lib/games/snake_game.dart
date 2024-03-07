import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SnakeGamePage extends StatefulWidget {
  final String username;
  const SnakeGamePage({super.key, required this.username});

  @override
  State<SnakeGamePage> createState() => _SnakeGamePageState();
}

enum Direction { up, down, left, right }

class _SnakeGamePageState extends State<SnakeGamePage> {
  int row = 20, column = 20;
  List<int> borderList = [];
  List<int> snakePosition = [];
  int snakeHead = 0;
  int score = 0;
  late Direction direction;
  late int foodPoistion;
  late FirebaseFirestore _firestore;

  @override
  void initState() {
    _firestore = FirebaseFirestore.instance;
    startGame();
    super.initState();
  }

  void startGame() {
    score = 0;
    makeBorder();
    generateFood();
    direction = Direction.right;
    snakePosition = [45, 44, 43];
    snakeHead = snakePosition.first;
    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      updateSnake();
      if (checkCollision()) {
        timer.cancel();
        showGameOverDialog();
      }
    });
  }

  Future<void> showGameOverDialog() async {
    // Get the reference to the user document using the username
    DocumentReference userRef =
        _firestore.collection('users').doc(widget.username);

    // Get the current score1 from the database
    DocumentSnapshot userSnapshot = await userRef.get();
    int bestScore = userSnapshot.get('score1') ?? 0;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Game Over",
            style: TextStyle(
              color: Colors.red, // Title text color
              fontSize: 24, // Title text size
              fontWeight: FontWeight.bold, // Title text weight
            ),
          ),
          content: Column(
            children: [
              Text(
                "Your snake collided!",
                style: TextStyle(
                  fontSize: 18, // Content text size
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "${widget.username}",
                style: TextStyle(
                  fontSize: 20, // Content text size
                  fontWeight: FontWeight.bold, // Content text weight
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Your best score: $bestScore",
                style: TextStyle(
                  fontSize: 20, // Content text size
                  fontWeight: FontWeight.bold, // Content text weight
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Your Score: $score",
                style: TextStyle(
                  fontSize: 20, // Content text size
                  fontWeight: FontWeight.bold, // Content text weight
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Push the score to the database before restarting the game
                pushScoreToDatabase(widget.username, score);
                
                Navigator.of(context).pop(); // Close the dialog
                startGame();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Restart button color
                onPrimary: Colors.white, // Restart button text color
              ),
              child: Text(
                "Restart",
                style: TextStyle(
                  fontSize: 18, // Restart button text size
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Push the score to the database before restarting the game
                pushScoreToDatabase(widget.username, score);

                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Close the SnakeGamePage
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Exit Game button color
                onPrimary: Colors.white, // Exit Game button text color
              ),
              child: Text(
                "Exit Game",
                style: TextStyle(
                  fontSize: 18, // Exit Game button text size
                ),
              ),
            ),
          ],
          backgroundColor: Colors.grey[200], // Background color of the dialog
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Border radius
          ),
        );
      },
    );
  }

  bool checkCollision() {
    //if snake collid with border
    if (borderList.contains(snakeHead)) return true;
    //if snake collid with itself
    if (snakePosition.sublist(1).contains(snakeHead)) return true;
    return false;
  }

  void generateFood() {
    foodPoistion = Random().nextInt(row * column);
    if (borderList.contains(foodPoistion)) {
      generateFood();
    }
  }

  void updateSnake() {
    setState(() {
      switch (direction) {
        case Direction.up:
          snakePosition.insert(0, snakeHead - column);
          break;
        case Direction.down:
          snakePosition.insert(0, snakeHead + column);
          break;
        case Direction.right:
          snakePosition.insert(0, snakeHead + 1);
          break;
        case Direction.left:
          snakePosition.insert(0, snakeHead - 1);
          break;
      }
    });

    if (snakeHead == foodPoistion) {
      score++;
      generateFood();
    } else {
      snakePosition.removeLast();
    }

    snakeHead = snakePosition.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Expanded(child: _buildGameView()), _buildGameControls()],
      ),
    );
  }

  Widget _buildGameView() {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: column),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: fillBoxColor(index)),
        );
      },
      itemCount: row * column,
    );
  }

  Widget _buildGameControls() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Score : $score"),
          IconButton(
            onPressed: () {
              if (direction != Direction.down) direction = Direction.up;
            },
            icon: const Icon(Icons.arrow_circle_up),
            iconSize: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (direction != Direction.right) direction = Direction.left;
                },
                icon: const Icon(Icons.arrow_circle_left_outlined),
                iconSize: 100,
              ),
              const SizedBox(width: 100),
              IconButton(
                onPressed: () {
                  if (direction != Direction.left) direction = Direction.right;
                },
                icon: const Icon(Icons.arrow_circle_right_outlined),
                iconSize: 100,
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              if (direction != Direction.up) direction = Direction.down;
            },
            icon: const Icon(Icons.arrow_circle_down_outlined),
            iconSize: 100,
          ),
        ],
      ),
    );
  }

  Color fillBoxColor(int index) {
    if (borderList.contains(index))
      return Colors.yellow;
    else {
      if (snakePosition.contains(index)) {
        if (snakeHead == index) {
          return Colors.green;
        } else {
          return Color.fromARGB(255, 162, 233, 122).withOpacity(0.9);
        }
      } else {
        if (index == foodPoistion) {
          return Colors.red;
        }
      }
    }
    return Colors.grey.withOpacity(0.05);
  }

  makeBorder() {
    for (int i = 0; i < column; i++) {
      if (!borderList.contains(i)) borderList.add(i);
    }
    for (int i = 0; i < row * column; i = i + column) {
      if (!borderList.contains(i)) borderList.add(i);
    }
    for (int i = column - 1; i < row * column; i = i + column) {
      if (!borderList.contains(i)) borderList.add(i);
    }
    for (int i = (row * column) - column; i < row * column; i = i + 1) {
      if (!borderList.contains(i)) borderList.add(i);
    }
  }

  Future<void> pushScoreToDatabase(String username, int score) async {
    try {
      // Get the reference to the user document using the username
      DocumentReference userRef =
          _firestore.collection('users').doc(widget.username);

      // Get the current score1 from the database
      DocumentSnapshot userSnapshot = await userRef.get();
      int currentScore1 = userSnapshot.get('score1') ?? 0;

      // Update the score1 field in the user document only if the new score is greater
      if (score > currentScore1) {
        await userRef.update({'score1': score});
        print("Score pushed to database successfully");
      } else {
        print(
            "Score not updated. New score is not greater than the current score in the database.");
      }
    } catch (error) {
      print("Failed to push score to database: $error");
    }
  }
}
