import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  ImageButton({@required this.image, this.label, @required this.onTap});

  final ImageProvider image;
  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: image,
              radius: 100.0,
              backgroundColor: Colors.deepPurple,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
