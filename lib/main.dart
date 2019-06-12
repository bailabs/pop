import 'package:flutter/material.dart';
import 'package:pop/models/quiz.dart';
import 'package:pop/screens/game_stat.dart';
import 'package:pop/screens/loading.dart';
import 'package:pop/screens/menu.dart';
import 'package:pop/utils/constants.dart';
import 'package:provider/provider.dart';

void main() => runApp(Pop());

class Pop extends StatelessWidget {
  static const String _title = 'Pop!';
  final Quiz quiz = Quiz();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Quiz>(
        builder: (_) {
          return quiz;
        },
        child: MaterialApp(
          title: _title,
          debugShowCheckedModeBanner: false,
          home: Menu(),
          routes: {
            'menu': (context) => Menu(),
            'quizArtist': (context) {
              quiz.setType(QuizType.artist);
              quiz.loadData();
              quiz.generateQuestions();
              return Loading();
            },
            'quizShow': (context) {
              quiz.setType(QuizType.show);
              quiz.loadData();
              quiz.generateQuestions();
              return Loading();
            },
            'gameStat': (context) => GameStat(),
          },
          initialRoute: 'menu',
        ));
  }
}
