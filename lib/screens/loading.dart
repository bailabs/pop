import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pop/models/quiz.dart';
import 'package:pop/screens/quiz_display.dart';
import 'package:provider/provider.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<Quiz>(context);
    return quiz.length() > 0 ? QuizDisplay() : spinner();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Cannot connect internet"),
          content: new Text("Please check your internet connection"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Back"),
              onPressed: () {
                Navigator.pushNamed(context, 'menu');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 20), () {
      final quiz = Provider.of<Quiz>(context);
      if (quiz.isLoading() && quiz.length() <= 0) {
        _showDialog();
      }
    });
  }
}

Widget spinner() {
  return Scaffold(
    backgroundColor: Colors.deepPurple,
    body: Center(
      child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      ),
    ),
  );
}
