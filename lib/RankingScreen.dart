// pachara bunjong 640510670 

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'widget/RankingBlog.dart';

class RankingScreen extends StatefulWidget {
  final String username;

  const RankingScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').where('score1', isNotEqualTo: 0).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          // Extract usernames and scores from the documents
          List<Map<String, dynamic>> userScores = snapshot.data!.docs
              .map((doc) => {
                    'username': doc.id,
                    'score': doc.get('score1'),
                  })
              .toList();

          // Sort userScores by score in descending order
          userScores.sort((a, b) => b['score'].compareTo(a['score']));

          return SizedBox(
            width: 400, // Set your desired width
            height: 550, // Set your desired height
            child: ListView.builder(
              itemCount: userScores.length,
              itemBuilder: (BuildContext context, int index) {
                String username = userScores[index]['username'];
                int score = userScores[index]['score'];

                // Use username and score in RankingBlog widget
                return RankingBlog(username: username, score: score, index: index);
              },
            ),
          );
        },
      ),
    );
  }
}
