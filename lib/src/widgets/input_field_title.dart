// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';

class InputTitle extends StatelessWidget {
  final String title;
  const InputTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Title(
      color: Colors.white,
      child: Text(
        title,
        style: const TextStyle(
          color: kTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
