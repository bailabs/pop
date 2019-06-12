import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:pop/components/choose_image.dart';
import 'package:pop/components/score_display.dart';
import 'package:pop/models/quiz.dart';
import 'package:pop/screens/correct_wrong_overlay.dart';
import 'package:pop/utils/constants.dart';
import 'package:provider/provider.dart';

class QuizDisplay extends StatefulWidget {
  @override
  _QuizDisplayState createState() => _QuizDisplayState();
}

class _QuizDisplayState extends State<QuizDisplay> {
  bool overlayShouldBeVisible = false;
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
  }

  play(String url) async {
    final AudioCache player = AudioCache();
    player.play(url);
  }

  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<Quiz>(context);

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade600,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                ChooseImage(
                  leftLabel: quiz.length() > 0
                      ? quiz.getChoice(ChoiceType.left).name
                      : '',
                  rightLabel: quiz.length() > 0
                      ? quiz.getChoice(ChoiceType.right).name
                      : '',
                  leftImage: quiz.length() > 0 &&
                          quiz.getChoice(ChoiceType.left).image != null
                      ? NetworkImage(quiz.getChoice(ChoiceType.left).image)
                      : AssetImage('images/music.png'),
                  rightImage: quiz.length() > 0 &&
                          quiz.getChoice(ChoiceType.right).image != null
                      ? NetworkImage(quiz.getChoice(ChoiceType.right).image)
                      : AssetImage('images/music.png'),
                  leftTap: () {
                    this.setState(() {
                      overlayShouldBeVisible = true;
                      if (quiz.isAnswer(ChoiceType.left)) {
                        play('correct.mp3');
                        isCorrect = true;
                        quiz.incrementScore();
                      } else {
                        isCorrect = false;
                        play('lose.mp3');
                      }
                    });
                  },
                  rightTap: () {
                    this.setState(() {
                      overlayShouldBeVisible = true;
                      if (quiz.isAnswer(ChoiceType.right)) {
                        isCorrect = true;
                        play('correct.mp3');
                        quiz.incrementScore();
                      } else {
                        isCorrect = false;
                        play('lose.mp3');
                      }
                    });
                  },
                ),
                ScoreDisplay(
                  score: quiz.getScore(),
                ),
              ],
            ),
            overlayShouldBeVisible == true
                ? new CorrectWrongOverlay(
                    this.isCorrect,
                    () async {
                      if (this.isCorrect == false) {
                        await quiz.saveData();
                        await quiz.processRank();
                        Navigator.pushNamed(context, 'gameStat');
                      }
                      this.setState(() {
                        overlayShouldBeVisible = false;
                        quiz.nextQuestion();
                      });
                    },
                  )
                : new Container()
          ],
        ),
      ),
    );
  }
}
