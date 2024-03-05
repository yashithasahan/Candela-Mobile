import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MembershipLevelButton extends StatelessWidget {
  final int level;
  final Color textColor;
  final List<Color> btnColor;
  final VoidCallback press;
  const MembershipLevelButton({
    super.key,
    required this.level,
    required this.press,
    required this.textColor,
    required this.btnColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: 73,
        height: 23,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: btnColor,
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.circular(38)),
        child: Center(
          child: Text(
            '${'level'.tr} $level',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
