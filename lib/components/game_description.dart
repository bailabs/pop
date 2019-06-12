import 'package:flutter/material.dart';

class GameDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Container(
          child: Text(
            'There are 2 categories music artists and movies. Based on Billboard\'s artist ranking and The Movie Database popular movies.',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );
  }
}
