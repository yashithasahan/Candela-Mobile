// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:candela_maker/src/constants/constants.dart';

class MembershipLevelDescription extends StatelessWidget {
  final String description;
  const MembershipLevelDescription({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 6, right: 16, bottom: 13, left: 12),
      width: 216,
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF1D1D1D),
            blurRadius: 1,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Text(
        description,
        style: const TextStyle(
          color: kTextColor,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
