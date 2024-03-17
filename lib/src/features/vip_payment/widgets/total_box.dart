import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class TotalBox extends StatelessWidget {
  const TotalBox({
    super.key,
    required this.width,
    required this.fontSize, required this.text,
  });

  final double width;
  final double fontSize;
  final String text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      width: size.width * width,
      decoration: BoxDecoration(
          border: Border.all(color: kTextColor),
          borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: Text(
          '\$ $text',
          style: TextStyle(color: kTextColor, fontSize: fontSize),
        ),
      ),
    );
  }
}