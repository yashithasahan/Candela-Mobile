// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';

class InputTitle extends StatelessWidget {
  final String title;
  const InputTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

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
