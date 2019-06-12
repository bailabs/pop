import 'package:flutter/material.dart';

class ScoreDisplay extends StatelessWidget {
  ScoreDisplay({this.score});
  final int score;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(
                '$score',
                style: TextStyle(
                  fontSize: 90.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade300,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                ' score',
                style: TextStyle(fontSize: 20.0, color: Colors.grey.shade500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
