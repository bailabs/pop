import 'package:flutter/material.dart';
import 'package:pop/models/quiz.dart';
import 'package:provider/provider.dart';

class GameStatHeader extends StatelessWidget {
  List<Widget> _score({String score, String label, double fontSize}) {
    return [
      Text(
        label,
        style: TextStyle(
          fontFamily: 'PaytoneOne',
          color: Colors.white70,
          fontSize: 20.0,
        ),
      ),
      Text(
        score,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<Quiz>(context);
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          color: Colors.deepPurple,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: _score(
                fontSize: 80.0,
                label: 'Score',
                score: quiz.getScore().toString(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: _score(
                      fontSize: 50.0,
                      label: 'Rank',
                      score: quiz.getCurrentUser() != null
                          ? quiz.getRank().toString()
                          : '?',
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                Expanded(
                  child: Column(
                    children: _score(
                      fontSize: 50.0,
                      label: 'Best Score',
                      score: quiz.getBestScore().toString(),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
