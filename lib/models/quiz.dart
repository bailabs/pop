import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pop/models/choice.dart';
import 'package:pop/models/question.dart';
import 'package:pop/utils/billboard.dart' as billboard;
import 'package:pop/utils/constants.dart';
import 'package:pop/utils/themoviedb.dart' as themoviedb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trotter/trotter.dart';

List shuffle(List items) {
  var random = new Random();

  for (var i = items.length - 1; i > 0; i--) {
    var n = random.nextInt(i + 1);
    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}

class Quiz with ChangeNotifier {
  QuizType _type;
  List _questions = [];
  int _score = 0;
  int _questionNumber = 1;
  int _bestScore = 0;
  int _rank = 0;
  bool _loading = false;
  FirebaseUser _currentUser;

  isLoading() {
    return _loading;
  }

  reset() {
    _questions = [];
    _questionNumber = 1;
    _score = 0;
  }

  setType(QuizType type) {
    _type = type;
  }

  QuizType getType() {
    return _type;
  }

  setCurrentUser(FirebaseUser user) {
    _currentUser = user;
    processRank();
    notifyListeners();
  }

  Future generateQuestions() async {
    List<dynamic> combosQuestions = [];
    List<Choice> apiData = [];
    var charts = QuizType.artist == _type ? ArtistCharts : ShowCharts;

    _loading = true;
    for (String chart in charts) {
      if (_type == QuizType.artist) {
        apiData = await billboard.getBillboardCharts(chart: chart);
      } else {
        apiData = await themoviedb.getMovieData(chart: chart);
      }

      if (apiData.length > 0) {
        var combos = Combinations(2, apiData);
        for (List<dynamic> combo in combos()) {
          combosQuestions.add(
            Question(
              category: chart,
              selection: shuffle(combo),
            ),
          );
        }
      }
    }
    _loading = false;
    _questions = shuffle(combosQuestions);
    notifyListeners();
  }

  Future loadData() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _bestScore = prefs.getInt('bestScore' + _type.toString());
    _bestScore = _bestScore == null ? 0 : _bestScore;
    _currentUser = await _auth.currentUser();

    if (_currentUser != null) {
      var data = await getRemoteBestScore();
      if (data != null && data['score'] > _bestScore) {
        _bestScore = data['score'];
        saveData();
      }
    }
  }

  Future getRemoteBestScore() async {
    if (_currentUser != null) {
      QuerySnapshot storeData = await Firestore.instance
          .collection('scores')
          .where(
            'username',
            isEqualTo: _currentUser.displayName,
          )
          .where(
            'type',
            isEqualTo: _type.toString(),
          )
          .getDocuments();
      if (storeData.documents != null && storeData.documents.length > 0) {
        return {
          'score': storeData.documents.first['score'],
          'uuid': storeData.documents.first.documentID
        };
      } else {
        return null;
      }
    }
    return null;
  }

  Future processRank() async {
    if (_currentUser != null) {
      int rank = 1;
      QuerySnapshot storeData = await Firestore.instance
          .collection('scores')
          .where(
            'type',
            isEqualTo: _type.toString(),
          )
          .orderBy('score', descending: true)
          .getDocuments();
      for (var data in storeData.documents) {
        if (data['username'] == _currentUser.displayName) {
          _rank = rank;
          return null;
        }
        rank++;
      }
      _rank = rank;
    }
    notifyListeners();
    return null;
  }

  getRank() => _rank;

  getCurrentUser() => _currentUser;

  Future saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_currentUser != null) {
      var scoreData = await getRemoteBestScore();
      if (scoreData != null) {
        if (scoreData['score'] < _bestScore) {
          Firestore.instance
              .collection('scores')
              .document(scoreData['uuid'])
              .updateData({'score': _bestScore});
        }
      } else {
        Firestore.instance.collection('scores').add(
          {
            "score": _bestScore,
            "type": _type.toString(),
            "username": _currentUser.displayName,
          },
        );
      }
    }
    await prefs.setInt('bestScore' + _type.toString(), _bestScore);
    notifyListeners();
  }

  incrementScore() {
    _score++;
    _bestScore = (_score > _bestScore) ? _score : _bestScore;
    saveData();
    return _score;
  }

  resetScore() {
    _score = 0;
    notifyListeners();
  }

  getBestScore() => _bestScore;
  getScore() => _score;

  Choice getChoice(ChoiceType choiceType) {
    return _questions[_questionNumber]
        .selection[choiceType == ChoiceType.left ? 0 : 1];
  }

  nextQuestion() => _questionNumber++;

  int length() => _questions.length;

  bool isAnswer(ChoiceType choiceType) {
    return choiceType == ChoiceType.left
        ? getChoice(ChoiceType.left).rank < getChoice(ChoiceType.right).rank
        : getChoice(ChoiceType.left).rank > getChoice(ChoiceType.right).rank;
  }
}
