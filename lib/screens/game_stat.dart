import 'package:flutter/material.dart';
import 'package:pop/components/game_stat_header.dart';
import 'package:pop/components/game_stat_leaderboard.dart';
import 'package:pop/components/game_stat_login.dart';
import 'package:pop/models/quiz.dart';
import 'package:provider/provider.dart';

class GameStat extends StatefulWidget {
  @override
  _GameStatState createState() => _GameStatState();
}

class _GameStatState extends State<GameStat> {
  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<Quiz>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GameStatHeader(),
            quiz.getCurrentUser() != null
                ? GameStatLeaderBoard()
                : GameStatLogin(),
            Expanded(
              child: FlatButton(
                color: Colors.deepPurpleAccent,
                onPressed: () {
                  Navigator.pushNamed(context, 'menu');
                  quiz.reset();
                  quiz.resetScore();
                },
                child: Text(
                  'Play Again',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontFamily: 'PaytoneOne',
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
