import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CorrectIcon extends StatefulWidget {
  @override
  _CorrectIconState createState() => _CorrectIconState();
}

class _CorrectIconState extends State<CorrectIcon>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 100,
      vsync: this,
    );

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
      }
    });
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        child: Center(
          child: CircleAvatar(
            radius: controller.value,
            backgroundColor: Color(0xFF41b8f6),
            child: Icon(
              FontAwesomeIcons.check,
              color: Colors.white,
              size: controller.value,
            ),
          ),
        ),
      ),
    );
  }
}
