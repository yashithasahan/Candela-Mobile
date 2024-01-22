import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';

class ReportBox extends StatelessWidget {
  final String text;
  final String? subText;
  const ReportBox({
    super.key,
    required this.text,
    this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: kTextColor),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: const TextStyle(color: kTextColor),
                ),
                Text(
                  subText ?? '',
                  style: const TextStyle(color: kTextColor),
                ),
              ],
            ),
          )),
    );
  }
}
