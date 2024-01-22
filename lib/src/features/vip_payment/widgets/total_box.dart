import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class TotalBox extends StatelessWidget {
  const TotalBox({
    super.key,
    required this.width,
    required this.fontSize,
  });

  final double width;
  final double fontSize;

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
          '\$ 89',
          style: TextStyle(color: kTextColor, fontSize: fontSize),
        ),
      ),
    );
  }
}