import 'package:flutter/material.dart';

class GameRank extends StatelessWidget {
  GameRank({this.rank, this.name, this.score});

  final int rank;
  final String name;
  final int score;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Card(
                color: Colors.grey.shade400,
                child: Center(
                  child: Text(
                    '$rank',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade800,
                    fontFamily: 'PaytoneOne',
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Card(
                color: Colors.green.shade400,
                child: Center(
                  child: Text(
                    '$score',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PaytoneOne',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
