import 'package:flutter/material.dart';

class ReportRow extends StatelessWidget {
  final String text;
  final String subText;
  final Color textColor;
  const ReportRow({
    super.key,
    required this.text,
    required this.subText,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(color: textColor, fontSize: 20),
        ),
        Text(
          subText,
          style: TextStyle(color: textColor, fontSize: 20),
        ),
      ],
    );
  }
}