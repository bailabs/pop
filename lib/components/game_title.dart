import 'package:flutter/material.dart';

class GameTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 80.0,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Who is More Popular?',
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
              fontFamily: 'PaytoneOne',
            ),
          ),
        ),
      ),
    );
  }
}
