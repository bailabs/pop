import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pop/components/game_rank.dart';
import 'package:pop/models/quiz.dart';
import 'package:provider/provider.dart';

class GameStatLeaderBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int rank = 1;
    final quiz = Provider.of<Quiz>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('scores')
          .where(
            'type',
            isEqualTo: quiz.getType().toString(),
          )
          .orderBy('score', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Expanded(
              flex: 4,
              child: Center(
                child: new SpinKitDoubleBounce(
                  color: Colors.deepPurpleAccent,
                  size: 60.0,
                ),
              ),
            );
          default:
            return Expanded(
              flex: 4,
              child: new ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return new GameRank(
                    name: document['username'],
                    rank: rank++,
                    score: document['score'],
                  );
                }).toList(),
              ),
            );
        }
      },
    );
  }
}
