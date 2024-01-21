// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:candela_maker/src/constants/constants.dart';

class MembershipLevelButton extends StatelessWidget {
  final String level;
  const MembershipLevelButton({
    Key? key,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 73,
      height: 23,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFF59C0D),
              Color(0xFFDEA72C),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(38)),
      child: Center(
        child: Text(
          level,
          style: const TextStyle(
            color: kBgColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
