import 'package:flutter/material.dart';
import 'package:pop/components/game_description.dart';
import 'package:pop/components/game_title.dart';
import 'package:pop/components/menu_selection.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GameTitle(),
            GameDescription(),
            MenuSelection(),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 50.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
