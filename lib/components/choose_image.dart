import 'package:flutter/material.dart';
import 'package:pop/components/image_button.dart';

class ChooseImage extends StatelessWidget {
  ChooseImage({
    @required this.leftTap,
    @required this.rightTap,
    @required this.leftLabel,
    @required this.rightLabel,
    @required this.leftImage,
    @required this.rightImage,
  });

  final Function leftTap;
  final Function rightTap;

  final String leftLabel;
  final String rightLabel;

  final ImageProvider leftImage;
  final ImageProvider rightImage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ImageButton(
              image: leftImage,
              label: leftLabel,
              onTap: leftTap,
            ),
            SizedBox(
              width: 10.0,
            ),
            ImageButton(
              image: rightImage,
              label: rightLabel,
              onTap: rightTap,
            ),
          ],
        ),
      ),
    );
  }
}
