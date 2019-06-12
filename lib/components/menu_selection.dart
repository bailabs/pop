import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pop/components/menu_button.dart';

class MenuSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MenuButton(
            text: 'Artist',
            icon: FontAwesomeIcons.music,
            color: Colors.orangeAccent,
            onTap: () {
              Navigator.pushNamed(context, 'quizArtist');
            },
          ),
          MenuButton(
            text: 'Movies',
            icon: FontAwesomeIcons.film,
            color: Colors.lightBlue,
            onTap: () {
              Navigator.pushNamed(context, 'quizShow');
            },
          ),
        ],
      ),
    );
  }
}
