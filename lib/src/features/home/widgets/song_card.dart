import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/timer_controller.dart';

class SongCard extends StatelessWidget {
  const SongCard({super.key, required this.icon});
  final String icon;

  @override
  Widget build(BuildContext context) {
    final timerController = Get.put(TimerController());
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: mainPadding),
      width: 100,
      height: 83,
      decoration: BoxDecoration(
          color: kSecondaryColor, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            icon,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lovely",
                  style: TextStyle(
                      fontSize: 16,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  "Billie Eilish & Khalid",
                  style: TextStyle(
                      fontSize: 10,
                      color: kTextColor,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(notes),
                  Obx(
                    () => Text(
                      "\$ ${timerController.amout.value}",
                      style: const TextStyle(
                          fontSize: 14,
                          color: kTextColor,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
              Container(
                width: 79,
                height: 20,
                decoration: BoxDecoration(
                    color: kTextColor, borderRadius: BorderRadius.circular(38)),
                child: const Center(
                  child: Text(
                    "00:04:52",
                    style: TextStyle(
                        fontSize: 10,
                        color: kBlackColor,
                        fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
