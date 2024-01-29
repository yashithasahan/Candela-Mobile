import 'package:candela_maker/src/common_widgets/outine_button.dart';
import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/home/controllers/timer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FourButtons extends StatelessWidget {
  const FourButtons({super.key});

  @override

  Widget build(BuildContext context) {
    final timecontroller = Get.put(TimerController());
    return Column(
    
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlineButton(
              text: "\$ 35",
              press: () => {},
              width: 0.3,
              icon: SvgPicture.asset(
                mainNotes,
              ),
            ),
            OutlineButton(
                text: timecontroller.time.value, press: () => {}, width: 0.3)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlineButton(text: "Songs", press: () => {}, width: 0.3),
            OutlineButton(text: "Total", press: () => {}, width: 0.3)
          ],
        )
      ],
    );
  }
}
