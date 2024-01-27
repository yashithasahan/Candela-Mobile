
import 'package:flutter/material.dart';
import 'package:candela_maker/src/constants/constants.dart';
import 'package:get/get.dart';
import '../features/membership_level/controller/membership_controller.dart';

class MembershipLevelButton extends StatelessWidget {
  final int level;
  final VoidCallback press;
  const MembershipLevelButton({
    super.key,
    required this.level,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    final membershipController = Get.put(MembershipController());
    return Obx(
      () => InkWell(
        onTap: press,
        child: Container(
          width: 73,
          height: 23,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: membershipController.membershipLevel.value == level
                    ? [const Color(0xFFDEA72C), const Color(0xFFF59C0D)]
                    : [Colors.grey, Colors.grey],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.circular(38)),
          child: Center(
            child: Text(
              'Level $level',
              style: TextStyle(
                color: membershipController.membershipLevel.value == level
                    ? kBgColor
                    : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
