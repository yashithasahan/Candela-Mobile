import 'package:flutter/material.dart';

class ReportRow extends StatelessWidget {
  final String text;
  final String subText;
  final Color textColor;
  final Widget icon;
  const ReportRow({
    super.key,
    required this.text,
    required this.subText,
    required this.textColor,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              text,
              style: TextStyle(color: textColor, fontSize: 20),
            ),
            const SizedBox(width: 5),
            icon
          ],
        ),
        Text(
          subText,
          style: TextStyle(color: textColor, fontSize: 20),
        ),
      ],
    );
  }
}