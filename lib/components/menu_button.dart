import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  MenuButton(
      {@required this.text,
      @required this.icon,
      this.color,
      @required this.onTap,});

  final String text;
  final IconData icon;
  final Color color;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 20.0,
          margin: EdgeInsets.all(20.0),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue.shade900,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Icon(
                icon,
                color: color,
                size: 60.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
